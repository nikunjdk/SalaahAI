import 'dart:convert';

import 'package:salahml/app/app.locator.dart';
import 'package:salahml/app/app.router.dart';
import 'package:salahml/models/prediction_file_history_model.dart';
import 'package:salahml/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;
import 'package:stacked_services/stacked_services.dart';

class PredictionViewModel extends FutureViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  late History history;
  dynamic pResult;
  Map<String, String> predictColumns = {};
  PredictionViewModel(this.history);

  Future submitForPrediction() async {
    setBusy(true);
    final http.Response response = await http.post(
        Uri.http(
            _authenticationService.url, '/predict', {'file': history.fileId}),
        body: predictColumns);
    pResult = json.decode(response.body)['result'][0];
    notifyListeners();
    setBusy(false);
  }

  void predictAgain() {
    _navigationService.popRepeated(1);
    _navigationService.navigateTo(Routes.prediction,
        arguments: PredictionViewArguments(history: history));
  }

  void changeValue(int index2, String value) {
    predictColumns[predictColumns.keys.elementAt(index2)] = value;
    notifyListeners();
  }

  @override
  Future futureToRun() async {
    final http.Response response2 = await http.get(
      Uri.http(_authenticationService.url, '/getColumnsNeeded',
          {'file': history.fileId}),
    );
    List<String> pCols = json.decode(response2.body)['columns'].cast<String>();
    for (int i = 0; i < pCols.length; i++) {
      predictColumns[pCols[i]] = "";
    }
    notifyListeners();
  }
}
