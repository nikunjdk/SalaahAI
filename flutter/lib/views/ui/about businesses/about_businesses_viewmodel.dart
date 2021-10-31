import 'package:salahml/app/app.locator.dart';
import 'package:salahml/app/app.router.dart';
import 'package:salahml/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AboutBusinessesViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  late bool isSignedIn;
  AboutBusinessesViewModel() {
    isSignedIn = _authenticationService.isSignedIn;
  }
  void goToLogin() => _navigationService.navigateTo(Routes.login);
  void goToSignUp() => _navigationService.navigateTo(Routes.signup);
  void goToHome() => _navigationService.navigateTo(Routes.home);
}
