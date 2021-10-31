import 'package:firebase_auth/firebase_auth.dart';
import 'package:salahml/app/app.locator.dart';
import 'package:salahml/app/app.router.dart';
import 'package:salahml/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LandingViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  User? user;

  void goToAboutBusiness() =>
      _navigationService.navigateTo(Routes.about_business);
  void goToAboutDevelopers() =>
      _navigationService.navigateTo(Routes.about_developers);
  void goToSignUp() => _navigationService.navigateTo(Routes.signup);

  Future delay() async {
    await Future.delayed(const Duration(microseconds: 50));
    user = _authenticationService.user;
    notifyListeners();
  }
}
