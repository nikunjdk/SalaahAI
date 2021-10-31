import 'package:flutter/material.dart';
import 'package:salahml/views/widgets/dumb/form_button.dart';
import 'package:salahml/views/widgets/smart/layout/layout.dart';
import 'package:stacked/stacked.dart';

import 'add_file_viewmodel.dart';

class AddFileView extends StatelessWidget {
  const AddFileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<AddFileViewModel>.reactive(
      builder: (context, viewModel, child) => Layout(
        body: SafeArea(
          child: Center(
            child: viewModel.isBusy
                ? const CircularProgressIndicator.adaptive()
                : viewModel.result == null
                    ? const Text("No File Chosen")
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              const Text(
                                "Choose the feature you want to predict",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.1),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Wrap(
                                  spacing: 5.0,
                                  runSpacing: 10.0,
                                  children: List<Widget>.generate(
                                    viewModel.columns.length,
                                    (index) => SizedBox(
                                      width: screenWidth * 0.3,
                                      child: ListTile(
                                        title: Text(
                                          viewModel.columns[index]
                                              .replaceAll("_", " "),
                                        ),
                                        leading: Radio(
                                          fillColor: MaterialStateProperty.all(
                                              Colors.white),
                                          groupValue: viewModel.selectedColumn,
                                          value: viewModel.columns[index],
                                          onChanged: (String? value) {
                                            viewModel.selectedColumn = value;
                                            viewModel.notifyListeners();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.1),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<bool>(
                                    dropdownColor: Colors.blueGrey,
                                    iconEnabledColor: Colors.white,
                                    style: const TextStyle(color: Colors.white),
                                    hint: const Text(
                                      "Choose type of prediction",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    value: viewModel.isClassification,
                                    onChanged: (value) {
                                      viewModel.isClassification = value;
                                      viewModel.notifyListeners();
                                    },
                                    items: const <DropdownMenuItem<bool>>[
                                      DropdownMenuItem(
                                        child: Text(
                                          "Classification",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        value: true,
                                      ),
                                      DropdownMenuItem(
                                        child: Text(
                                          "Regression",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        value: false,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.1),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: FormButton(
                                  text: "Submit",
                                  onPressed: viewModel.submitColumns,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
          ),
        ),
      ),
      viewModelBuilder: () => AddFileViewModel(),
    );
  }
}
