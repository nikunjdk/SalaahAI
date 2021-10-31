import 'package:salahml/services/authentication_service.dart';
import 'package:salahml/services/firestore_service.dart';
import 'package:salahml/views/ui/about%20businesses/about_businesses_view.dart';
import 'package:salahml/views/ui/about%20developers/about_developers_view.dart';
import 'package:salahml/views/ui/add%20file/add_file_view.dart';
import 'package:salahml/views/ui/home/home_view.dart';
import 'package:salahml/views/ui/landing/landing_view.dart';
import 'package:salahml/views/ui/login/login_view.dart';
import 'package:salahml/views/ui/prediction/prediction_view.dart';
import 'package:salahml/views/ui/signup/signup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

//Run 'flutter pub run build_runner build --delete-conflicting-outputs' after changes
@StackedApp(
  routes: [
    MaterialRoute(page: AboutBusinessesView, name: 'about_business'),
    MaterialRoute(page: AboutDevelopersView, name: 'about_developers'),
    MaterialRoute(page: AddFileView, name: 'add_file'),
    MaterialRoute(page: HomeView, name: 'home'),
    MaterialRoute(page: LandingView, name: 'landing', initial: true),
    MaterialRoute(page: LoginView, name: 'login'),
    MaterialRoute(page: PredictionView, name: 'prediction'),
    MaterialRoute(page: SignupView, name: 'signup'),
  ],
  dependencies: [
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: FirestoreService),
    Singleton(classType: AuthenticationService),
  ],
  logger: StackedLogger(),
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
