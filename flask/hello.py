from os import error
from typing import Collection
from flask import Flask, request, session
# from flask_session import Session
import pymongo
import uuid
import json
from bson import json_util
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import math

from mlbox.preprocessing import *
from mlbox.optimisation import *
from mlbox.prediction import *

# from celery import Celery
import dramatiq
import pickle


from dramatiq.brokers.redis import RedisBroker


redis_broker = RedisBroker(host="localhost")
dramatiq.set_broker(redis_broker)

def get_database():
    from pymongo import MongoClient
    import pymongo

    # Provide the mongodb atlas url to connect python to mongodb using pymongo
    CONNECTION_STRING = "mongodb://localhost:27017/mlbox"

    # Create a connection using MongoClient. You can import MongoClient or use pymongo.MongoClient
    from pymongo import MongoClient
    client = MongoClient(CONNECTION_STRING)

    # Create the database for our example (we will use the same database throughout the tutorial
    return client['mlbox']
    
dbname = get_database()
collection=dbname["modelDetails"]
app = Flask(__name__)
print(collection)
app.config['UPLOAD_FOLDER']="./uploads/datasets/"
app.config['TEST_FOLDER']="./uploads/testDataset/"
app.config['TRAINING_FOLDER']="./uploads/trainingDatasets/"
app.config['PICKLE_FOLDER']="./uploads/pickleFiles/"
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
app.config["SECRET_KEY"] = "gbfdvsfgbvcxvgshejnbavghj"
app.config['CELERY_BROKER_URL'] = 'redis://localhost:6379/0'
app.config['CELERY_RESULT_BACKEND'] = 'redis://localhost:6379/0'
# celery = Celery(app.name, broker=app.config['CELERY_BROKER_URL'])
# celery.conf.update(app.config)

headers = {'Access-Control-Allow-Origin': '*'}
trainCounter=0

@app.route('/')
def hello():
    return 'Hello, World!',200,headers

@app.route('/predict',methods=['POST'])
def predict():
    file=request.args.get("file")
    data=collection.find_one({"file":file})
    pickleFile=app.config['PICKLE_FOLDER']+data["pickleFile"]
    trainingColumn=data["trainingColumn"]
    loaded_model = pickle.load(open(pickleFile, 'rb'))
    columnsData=request.form.to_dict()
    dataPredict={}
    for i in data["columnsNeeded"]:
        temp=[]
        # print(i)
        temp.append(columnsData[i])
        dataPredict[i]=temp
    dataframe=pd.DataFrame(dataPredict)
    print(dataframe)
    result=loaded_model.predict(dataframe)
    result=result.tolist()
    return {"result":result},200,headers


@app.route('/status')
def status():
    file=request.args.get("file")
    data=collection.find_one({"file":file})
    return {"status":data["status"]},200,headers

@app.route('/getColumnsNeeded')
def getColumnsNeeded():
    file=request.args.get("file")
    data=collection.find_one({"file":file})
    # print(data["columnsNeeded"])
    print(data)
    return {"columns":data["columnsNeeded"]},200,headers

@app.route('/train',methods=['POST'])
def train():
    trainingColumn=request.form.get("trainingColumn")
    isClassification=request.form.get("isClassification")
    print(isClassification)
    file=request.form.get("file")
    xl=pd.read_excel(app.config['UPLOAD_FOLDER']+request.form.get("file"))
    columns=list(xl.columns)
    if trainingColumn in columns:
        collection.update_one({"file":file},{"$set":{"trainingColumn":trainingColumn,"status":"In Training"}})
        trainQueueTask.send(trainingColumn,file,isClassification)
        return "training column set and training",200,headers
    else:
        return "No Such Column",200,headers

@app.route('/columns')
def columns():
    objCount=collection.count_documents({"file":request.args.get("file")})
    if objCount>0:
        print("sent")
        xl=pd.read_excel(app.config['UPLOAD_FOLDER']+request.args.get("file"))
        return {"status":'Found',"columns":list(xl.columns)},200,headers
    else:
        return {"status":'No such file'},200,headers

@app.route('/session')
def helloSession():
    return session.get("dataset")

@app.route('/fileUpload',methods=['POST'])
def fileUpload():
    f=request.files['dataset']
    ext=f.filename.split(".")[-1]
    if ext=="xls":
        filename=uuid.uuid1().__str__()+"."+ext
        token=uuid.uuid1().__str__()
        f.save(app.config['UPLOAD_FOLDER']+filename)
        objDetails={
        "file":filename
        }
        collection.insert_one(objDetails)
        objDetails.pop("_id")
        objDetails["status"]="Correct"
        session["dataset"]=objDetails["file"]
        return json.loads(json_util.dumps(objDetails)),200,headers
    else:
        return {"status":"Wrong Extension"},200,headers

@dramatiq.actor
def trainQueueTask(target_name,file,isClassification):
    try:
        # target_name = "is_happy_customer"  #will change as per user choice
        xl=pd.read_excel(app.config['UPLOAD_FOLDER']+file)
        ndf=xl.loc[0:int(xl.shape[0]*0.03)]  #losing 3 percent of the data, for the sake of drifting process, i.e. removing unncessary columns
        xl.drop(xl.index[0:math.ceil(xl.shape[0]*0.03)],0,inplace=True)
        ndf.drop(target_name,axis='columns', inplace=True)
        ndf.to_excel(app.config['TEST_FOLDER']+file)
        xl.to_excel(app.config['TRAINING_FOLDER']+file)
        paths=[app.config['TRAINING_FOLDER']+file,app.config['TEST_FOLDER']+file]
        rd = Reader(sep = ',')
        df = rd.train_test_split(paths, target_name)
        dft = Drift_thresholder()
        df = dft.fit_transform(df)
        #this converts any remaining object columns, into categorical, since thats the only remaining type 
        for col in df['train'].columns:
            if df['train'].dtypes[col] == np.object:
                df['train'] = df['train'].astype({col:'category'})
        #confirming that all columns have the right datatype
        df['train'].info()
        from sklearn.model_selection import train_test_split
        X_train,X_test,Y_train,Y_test = train_test_split(df['train'],df['target'],test_size=0.2,random_state=42)
        # Training
        #for now, this code will work on classification task. Similarly can be done for regression.
        import autosklearn.classification
        import autosklearn.regression
        #time left for task, is in seconds, it decides how long to train the model. Can be a user input, to improve accuracy on very large datasets
        if isClassification=="true":
            automl = autosklearn.classification.AutoSklearnClassifier(time_left_for_this_task=30,per_run_time_limit=5)
        else:
            automl=autosklearn.regression.AutoSklearnRegressor(time_left_for_this_task=30,per_run_time_limit=5)
        print(automl)
        automl.fit(X_train,Y_train)
        print("AutoSkLearn Model Accuracy: {:2f}%".format(automl.score(X_test,Y_test)*100))
        print(automl.sprint_statistics())
        print(automl.leaderboard())
        X_test.head()
        import pickle
        # save the model to disk
        initFilename=file.split(".")[0]
        filename = initFilename+'.sav'
        pickle.dump(automl, open(app.config['PICKLE_FOLDER']+filename, 'wb'))
        columns=list((X_test.columns))
        print(columns)
        data=collection.update_one({"file":file},{"$set":{"status":"Training Completed","pickleFile":filename,"columnsNeeded":columns}})
    except error:
        print(error)
        data=collection.update_one({"file":file},{"$set":{"status":"Error Occured"}})
