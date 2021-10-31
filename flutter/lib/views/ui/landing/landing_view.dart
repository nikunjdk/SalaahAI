import 'package:flutter/material.dart';
import 'package:salahml/views/widgets/dumb/form_button.dart';
import 'package:salahml/views/widgets/smart/layout/layout.dart';
import 'package:stacked/stacked.dart';

import 'landing_viewmodel.dart';

class LandingView extends StatelessWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<LandingViewModel>.reactive(
      onModelReady: (viewModel) async => await viewModel.delay(),
      builder: (context, viewModel, child) => Layout(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: screenHeight * 0.25),
                const Text(
                  "SalaahAI",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
                const Text(
                  "Your personal and easy to use AI Advisor",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                SizedBox(height: screenHeight * 0.1),
                Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  runSpacing: 10.0,
                  children: [
                    FormButton(
                      text: 'For Business',
                      onPressed: viewModel.goToAboutBusiness,
                    ),
                    SizedBox(width: screenWidth * 0.1),
                    FormButton(
                      text: 'For Developers',
                      // onPressed: viewModel.goToAboutDevelopers,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => LandingViewModel(),
    );
  }
}
