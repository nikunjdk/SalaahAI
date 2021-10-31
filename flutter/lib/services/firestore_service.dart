import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salahml/models/prediction_file_history_model.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<History>> getHistory(String uid) async {
    List<History> predHistory = [];
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection('prediction file').doc(uid).get();
    if (snapshot.exists) {
      Map<String, dynamic> historyList =
          snapshot.data() as Map<String, dynamic>;
      PredictionFileHistory history =
          PredictionFileHistory.fromMap(historyList);
      predHistory = history.history;
    }
    return predHistory;
  }

  Future addFile(String uid, History file) async {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await firestore.collection('prediction file').doc(uid).get();
    PredictionFileHistory fileHistory = PredictionFileHistory(history: []);
    if (doc.exists) {
      Map<String, dynamic> historyList = doc.data() as Map<String, dynamic>;
      fileHistory = PredictionFileHistory.fromMap(historyList);
    }
    fileHistory.history.add(file);
    await firestore
        .collection('prediction file')
        .doc(uid)
        .set(fileHistory.toMap());
  }

  Future updateFile(String uid, int index) async {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await firestore.collection('prediction file').doc(uid).get();
    PredictionFileHistory fileHistory = PredictionFileHistory(history: []);
    Map<String, dynamic> historyList = doc.data() as Map<String, dynamic>;
    fileHistory = PredictionFileHistory.fromMap(historyList);
    fileHistory.history[index].isReady = true;
    await firestore
        .collection('prediction file')
        .doc(uid)
        .set(fileHistory.toMap());
  }
}
