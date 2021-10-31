import 'package:firebase_auth/firebase_auth.dart';
import 'package:salahml/app/app.locator.dart';
import 'package:salahml/app/app.router.dart';
import 'package:salahml/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignupViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  late String name, email, password, confirmPassword;
  String? emailError, passwordError, nameError;
  User? user;

  SignupViewModel() {
    user = _authenticationService.user;
    name = "";
    email = "";
    password = "";
    confirmPassword = "";

    nameError = null;
    emailError = null;
    passwordError = null;
  }

  void resetErrorText() {
    nameError = null;
    emailError = null;
    passwordError = null;
  }

  bool validate() {
    resetErrorText();

    if (name.isEmpty) {
      name = "Please enter a name";
    }

    RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    bool isValid = true;
    if (email.isEmpty || !emailExp.hasMatch(email)) {
      emailError = "Email is invalid";
      isValid = false;
    }

    if (password.isEmpty || confirmPassword.isEmpty) {
      passwordError = "Please enter a password";
      isValid = false;
    }
    if (password != confirmPassword) {
      passwordError = "Passwords do not match";
      isValid = false;
    }

    notifyListeners();
    return isValid;
  }

  void submit() async {
    if (validate()) {
      setBusy(true);
      await _authenticationService.signUp(
          name: name, email: email, password: password);
      setBusy(false);
    }
  }

  void changeName(String value) {
    name = value;
    notifyListeners();
  }

  void changeEmail(String value) {
    email = value;
    notifyListeners();
  }

  void changePassword(String value) {
    password = value;
    notifyListeners();
  }

  void changeConfirmPassword(String value) {
    confirmPassword = value;
    notifyListeners();
  }

  void goToLogin() => _navigationService.navigateTo(Routes.login);
}
