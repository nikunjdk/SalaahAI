import 'dart:convert';

import 'package:salahml/app/app.locator.dart';
import 'package:salahml/app/app.router.dart';
import 'package:salahml/models/prediction_file_history_model.dart';
import 'package:salahml/services/authentication_service.dart';
import 'package:salahml/services/firestore_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http/http.dart' as http;

class HomeViewModel extends FutureViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  late List<History> history;
  void goToProcess() => _navigationService.navigateTo(Routes.add_file);
  late String name;

  Future checkStatus(int index) async {
    setBusy(true);
    final http.Response response = await http.get(
      Uri.http(_authenticationService.url, '/status',
          {'file': history[index].fileId}),
    );
    String status = json.decode(response.body)['status'];
    if (status == 'Training Completed') {
      history[index].isReady = true;
      _firestoreService.updateFile(_authenticationService.user!.uid, index);
      notifyListeners();
    } else {
      _snackbarService.showSnackbar(message: "Model still in training");
    }
    setBusy(false);
  }

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

  void goToPredict(int index) =>
      _navigationService.navigateTo(Routes.prediction,
          arguments: PredictionViewArguments(history: history[index]));

  @override
  Future futureToRun() async {
    history =
        await _firestoreService.getHistory(_authenticationService.user!.uid);
    name = _authenticationService.user!.displayName!;
    notifyListeners();
  }
}
