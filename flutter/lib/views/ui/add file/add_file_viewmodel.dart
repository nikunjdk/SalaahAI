import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:file_picker/file_picker.dart';
import 'package:salahml/app/app.locator.dart';
import 'package:salahml/app/app.router.dart';
import 'package:salahml/models/prediction_file_history_model.dart';
import 'package:salahml/services/authentication_service.dart';
import 'package:salahml/services/firestore_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddFileViewModel extends FutureViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  FilePickerResult? result;
  String? status;

  late String fileNameId;
  List<String> columns = [];
  bool? isClassification;
  dynamic pResult;
  Map<String, String> predictColumns = {};
  String? selectedColumn;
  late History history;

  void submitColumns() async {
    setBusy(true);
    if (selectedColumn != null && isClassification != null) {
      history.isClassification = isClassification;
      history.selectedColumn = selectedColumn;
      await http.post(Uri.http(_authenticationService.url, '/train'), body: {
        'trainingColumn': selectedColumn,
        'file': fileNameId,
        'isClassification': isClassification.toString(),
      });
      await _firestoreService.addFile(
          _authenticationService.user!.uid, history);
      _navigationService.popRepeated(2);
      _navigationService.navigateTo(Routes.home);
      notifyListeners();
    } else {
      _snackbarService.showSnackbar(
          message: "Please select all the apropriate values to continue");
    }
    setBusy(false);
  }

  @override
  Future futureToRun() async {
    result = await FilePicker.platform.pickFiles(
      dialogTitle: "Upload database",
      type: FileType.custom,
      allowedExtensions: ['xls'],
      withReadStream: true,
    );
    if (result != null) {
      PlatformFile platformFile = result!.files.first;
      final http.MultipartRequest request = http.MultipartRequest(
        "POST",
        Uri.http(_authenticationService.url, "/fileUpload"),
      );
      request.files.add(http.MultipartFile(
        "dataset",
        platformFile.readStream!,
        platformFile.size,
        filename: platformFile.name,
      ));
      http.StreamedResponse response = await request.send();
      http.Response res = await http.Response.fromStream(response);
      fileNameId = json.decode(res.body)['file'];
      history = History(fileId: fileNameId, name: platformFile.name);
      final queryParameters = {'file': fileNameId};
      final http.Response response2 = await http.get(
          Uri.http(_authenticationService.url, '/columns', queryParameters));
      columns = json.decode(response2.body)['columns'].cast<String>();
      notifyListeners();
    } else {
      DialogResponse? response = await _dialogService.showConfirmationDialog(
        title: "No File Chosen",
        description: "Please choose a xls file to continue",
        confirmationTitle: "Pick a file",
        cancelTitle: "Go Back",
      );
      if (response != null && response.confirmed) {
        await futureToRun();
      } else {
        _navigationService.back();
      }
    }
  }
}
