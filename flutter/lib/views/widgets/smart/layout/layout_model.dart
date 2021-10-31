import 'package:salahml/app/app.locator.dart';
import 'package:salahml/app/app.router.dart';
import 'package:salahml/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LayoutModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  void goToLogin() => _navigationService.navigateTo(Routes.login);
  void goToSignUp() => _navigationService.navigateTo(Routes.signup);
  void goToHome() => _navigationService.navigateTo(Routes.home);
  void goToLanding() => _navigationService.navigateTo(Routes.landing);
  void signOut() async {
    DialogResponse? response = await _dialogService.showConfirmationDialog(
      title: "ALERT!",
      description: "Do you really want to sign out?",
      confirmationTitle: "Yes",
      cancelTitle: "No",
    );
    if (response != null && response.confirmed) {
      _authenticationService.signOut();
    }
  }
}
