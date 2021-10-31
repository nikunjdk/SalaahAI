import 'package:flutter/material.dart';
import 'package:salahml/models/prediction_file_history_model.dart';
import 'package:salahml/views/widgets/dumb/form_button.dart';
import 'package:salahml/views/widgets/dumb/input_field.dart';
import 'package:salahml/views/widgets/smart/layout/layout.dart';
import 'package:stacked/stacked.dart';

import 'prediction_viewmodel.dart';

class PredictionView extends StatelessWidget {
  final History history;
  const PredictionView({Key? key, required this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<PredictionViewModel>.reactive(
      builder: (context, viewModel, child) => Layout(
        body: SafeArea(
          child: Center(
            child: viewModel.isBusy
                ? const CircularProgressIndicator.adaptive()
                : viewModel.pResult == null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                                SizedBox(
                                  height: screenHeight * .1,
                                ),
                                const Text(
                                  "Enter the values to predict data accordingly",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.05),
                              ] +
                              List<Widget>.generate(
                                viewModel.predictColumns.length,
                                (index2) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InputField(
                                    onChanged: (value) =>
                                        viewModel.changeValue(index2, value),
                                    labelText: viewModel.predictColumns.keys
                                        .elementAt(index2),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ) +
                              [
                                SizedBox(height: screenHeight * 0.05),
                                Center(
                                  child: FormButton(
                                    text: 'Predict',
                                    onPressed: viewModel.submitForPrediction,
                                  ),
                                ),
                              ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Prediction: " + viewModel.pResult.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40.0,
                              ),
                            ),
                            SizedBox(height: screenHeight * .1),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 200.0),
                              child: FormButton(
                                text: "Predict Again",
                                onPressed: viewModel.predictAgain,
                              ),
                            ),
                          ],
                        ),
                      ),
          ),
        ),
      ),
      viewModelBuilder: () => PredictionViewModel(history),
    );
  }
}
