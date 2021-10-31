import 'package:firebase_auth/firebase_auth.dart';
import 'package:salahml/app/app.locator.dart';
import 'package:salahml/app/app.router.dart';
import 'package:salahml/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  late String email, password;
  String? emailError, passwordError;
  User? user;

  LoginViewModel() {
    user = _authenticationService.user;
    email = "";
    password = "";

    emailError = null;
    passwordError = null;
  }

  void resetErrorText() {
    emailError = null;
    passwordError = null;
    notifyListeners();
  }

  bool validate() {
    resetErrorText();

    RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    bool isValid = true;
    if (email.isEmpty || !emailExp.hasMatch(email)) {
      emailError = "Email is invalid";
      isValid = false;
      notifyListeners();
    }

    if (password.isEmpty) {
      passwordError = "Please enter a password";
      isValid = false;
      notifyListeners();
    }

    return isValid;
  }

  void submit() async {
    if (validate()) {
      setBusy(true);
      await _authenticationService.login(email: email, password: password);
      setBusy(false);
    }
  }

  void changeEmail(String value) {
    email = value;
    notifyListeners();
  }

  void changePassword(String value) {
    password = value;
    notifyListeners();
  }

  void goToSignUp() => _navigationService.navigateTo(Routes.signup);
}
