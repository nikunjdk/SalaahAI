import 'package:flutter/material.dart';
import 'package:salahml/views/widgets/dumb/form_button.dart';
import 'package:salahml/views/widgets/smart/layout/layout.dart';
import 'package:stacked/stacked.dart';

import 'about_businesses_viewmodel.dart';

class AboutBusinessesView extends StatelessWidget {
  const AboutBusinessesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder<AboutBusinessesViewModel>.reactive(
      builder: (context, viewModel, child) => Layout(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              // width: 400,
              height: screenHeight,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Get predictions to help improvise your business in 4 easy steps!",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.1),
                      SizedBox(
                        width: screenWidth * 0.7,
                        child: Card(
                          color: Colors.white.withOpacity(0.8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "1. Upload your file in xls format",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  const Text(
                                    "2. Choose the column you want to predict. Choose classification if you want to predict a class label (Eg. Yes/No) otherwise choose Regression if you want to predict a continuous number(Eg. Price)",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  const Text(
                                    "3. Wait for about 2 minutes. You can check the status of your model in the dashboard",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  const Text(
                                    "4. Predict your desired value by entering appropriate values.",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.1),
                      !viewModel.isSignedIn
                          ? Wrap(
                              alignment: WrapAlignment.center,
                              runAlignment: WrapAlignment.center,
                              runSpacing: 10.0,
                              children: [
                                FormButton(
                                  text: 'Sign Up',
                                  onPressed: viewModel.goToSignUp,
                                ),
                                SizedBox(width: screenWidth * 0.1),
                                FormButton(
                                  text: 'Login',
                                  onPressed: viewModel.goToLogin,
                                ),
                              ],
                            )
                          : FormButton(
                              text: 'Dashboard',
                              onPressed: viewModel.goToHome,
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => AboutBusinessesViewModel(),
    );
  }
}
