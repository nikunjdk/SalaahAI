import 'package:flutter/material.dart';
import 'package:salahml/views/widgets/dumb/form_button.dart';
import 'package:salahml/views/widgets/dumb/input_field.dart';
import 'package:salahml/views/widgets/smart/layout/layout.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, viewModel, child) => Layout(
        // isSignedIn: viewModel.user != null,
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: 400,
              height: screenHeight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(height: screenHeight * .05),
                    const Text(
                      "Welcome,",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * .01),
                    Text(
                      "Sign in to continue!",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(.8),
                      ),
                    ),
                    SizedBox(height: screenHeight * .07),
                    InputField(
                      onChanged: viewModel.changeEmail,
                      labelText: "Email",
                      errorText: viewModel.emailError,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      // autoFocus: true,
                    ),
                    SizedBox(height: screenHeight * .025),
                    InputField(
                      onChanged: viewModel.changePassword,
                      onSubmitted: (val) => viewModel.submit(),
                      labelText: "Password",
                      errorText: viewModel.passwordError,
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: screenHeight * .05,
                    ),
                    viewModel.isBusy
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : FormButton(
                            text: "Log In",
                            onPressed: viewModel.submit,
                          ),
                    SizedBox(
                      height: screenHeight * .05,
                    ),
                    TextButton(
                      onPressed: viewModel.goToSignUp,
                      child: RichText(
                        text: const TextSpan(
                          text: "I'm a new user, ",
                          style: TextStyle(color: Colors.white),
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                color: Colors.lightGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
