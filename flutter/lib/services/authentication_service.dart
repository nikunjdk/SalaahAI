import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:salahml/app/app.locator.dart';
import 'package:salahml/app/app.logger.dart';
import 'package:salahml/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthenticationService {
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final Logger _log = getLogger("AuthenticationService");
  FirebaseAuth auth = FirebaseAuth.instance;
  late bool isSignedIn;
  User? user;
  String url = "eedf-106-51-8-242.ngrok.io";

  AuthenticationService() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      this.user = user;
      if (user == null) {
        isSignedIn = false;
      } else {
        isSignedIn = true;
      }
    });
  }

  Future signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userCredential.user?.updateDisplayName(name);
      _snackbarService.showSnackbar(
        title: "Authentication Successful",
        message: "Welcome " + name,
      );
      await Future.delayed(const Duration(seconds: 1));
      _navigationService.clearStackAndShow(Routes.home);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _log.e('The password provided is too weak.');
        _snackbarService.showSnackbar(
          title: 'Authentication Error!',
          message: 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        _log.e('The account already exists for that email.');
        _snackbarService.showSnackbar(
          title: 'Authentication Error!',
          message: 'The account already exists for that email.',
        );
      }
    } catch (e) {
      _log.e(e);
      _snackbarService.showSnackbar(
        title: 'Authentication Error!',
        message: 'Something went wrong. Please try again later.',
      );
    }
  }

  Future login({required String email, required String password}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String name = userCredential.user?.displayName ?? "";
      _snackbarService.showSnackbar(
        title: "Authentication Successful",
        message: "Welcome " + name,
      );
      await Future.delayed(const Duration(seconds: 1));
      _navigationService.clearStackAndShow(Routes.home);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _log.e('No user found for that email.');
        _snackbarService.showSnackbar(
          title: 'Authentication Error!',
          message: 'No user found for that email.',
        );
      } else if (e.code == 'wrong-password') {
        _log.e('Wrong password provided for that user.');
        _snackbarService.showSnackbar(
          title: 'Authentication Error!',
          message: 'Wrong password provided for that user.',
        );
      }
    } catch (e) {
      _log.e(e);
      _snackbarService.showSnackbar(
        title: 'Authentication Error!',
        message: 'Something went wrong. Please try again later.',
      );
    }
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    _snackbarService.showSnackbar(message: "See you again");
    _navigationService.clearStackAndShow(Routes.landing);
  }
}
