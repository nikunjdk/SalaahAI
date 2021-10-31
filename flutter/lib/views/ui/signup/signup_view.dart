import 'package:flutter/material.dart';
import 'package:salahml/views/widgets/dumb/form_button.dart';
import 'package:salahml/views/widgets/dumb/input_field.dart';
import 'package:salahml/views/widgets/smart/layout/layout.dart';
import 'package:stacked/stacked.dart';

import 'signup_viewmodel.dart';

class SignupView extends StatelessWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return ViewModelBuilder<SignupViewModel>.reactive(
      builder: (context, viewModel, child) => Layout(
        // isSignedIn: viewModel.user != null,
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: 400,
              height: screenHeight,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(height: screenHeight * .04),
                    const Text(
                      "Create Account,",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * .01),
                    Text(
                      "Sign up to get started!",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(.8),
                      ),
                    ),
                    SizedBox(height: screenHeight * .05),
                    InputField(
                      onChanged: viewModel.changeName,
                      labelText: "Name",
                      errorText: viewModel.nameError,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: screenHeight * .025),
                    InputField(
                      onChanged: viewModel.changeEmail,
                      labelText: "Email",
                      errorText: viewModel.emailError,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: screenHeight * .025),
                    InputField(
                      onChanged: viewModel.changePassword,
                      labelText: "Password",
                      errorText: viewModel.passwordError,
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: screenHeight * .025),
                    InputField(
                      onChanged: viewModel.changeConfirmPassword,
                      onSubmitted: (value) => viewModel.submit(),
                      labelText: "Confirm Password",
                      errorText: viewModel.passwordError,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: screenHeight * .04,
                    ),
                    viewModel.isBusy
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : FormButton(
                            text: "Sign Up",
                            onPressed: viewModel.submit,
                          ),
                    SizedBox(
                      height: screenHeight * .02,
                    ),
                    TextButton(
                      onPressed: viewModel.goToLogin,
                      child: RichText(
                        text: const TextSpan(
                          text: "I'm already a member, ",
                          style: TextStyle(color: Colors.white),
                          children: [
                            TextSpan(
                              text: "Sign In",
                              style: TextStyle(
                                color: Colors.lightGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SignupViewModel(),
    );
  }
}
