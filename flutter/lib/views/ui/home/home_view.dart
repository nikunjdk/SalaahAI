import 'package:flutter/material.dart';
import 'package:salahml/models/prediction_file_history_model.dart';
import 'package:salahml/views/widgets/dumb/form_button.dart';
import 'package:salahml/views/widgets/smart/layout/layout.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, viewModel, child) => Layout(
        body: Center(
          child: viewModel.isBusy
              ? const CircularProgressIndicator.adaptive()
              : viewModel.history.isEmpty
                  ? Column(
                      children: [
                        SizedBox(height: screenHeight * .1),
                        Text(
                          "Welcome " + viewModel.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: screenHeight * .1),
                        const Text(
                          "No History\nPlease press + button to add a file for prediction",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),
                        SizedBox(height: screenHeight * .1),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.35),
                          child: FormButton(
                            text: "Sign Out",
                            onPressed: viewModel.signOut,
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        children: [
                          SizedBox(height: screenHeight * .1),
                          Text(
                            "Welcome " + viewModel.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: screenHeight * .05),
                          const Text(
                            "History",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 27.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: screenHeight * .1),
                          Center(
                            child: Wrap(
                              children: List.generate(viewModel.history.length,
                                  (index) {
                                History history = viewModel.history[index];
                                return SizedBox(
                                  width: 250,
                                  height: 150,
                                  child: Card(
                                    color: Colors.blue.withOpacity(0.8),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            history.name,
                                            style: const TextStyle(
                                                // color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          if (history.isReady)
                                            FormButton(
                                              text: "Predict",
                                              onPressed: () =>
                                                  viewModel.goToPredict(index),
                                            )
                                          else
                                            FormButton(
                                              text: "Check Status",
                                              onPressed: () =>
                                                  viewModel.checkStatus(index),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          SizedBox(height: screenHeight * .1),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.3),
                            child: FormButton(
                              text: "Sign Out",
                              onPressed: viewModel.signOut,
                            ),
                          ),
                        ],
                      ),
                    ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: viewModel.goToProcess,
          child: const Icon(Icons.add),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
