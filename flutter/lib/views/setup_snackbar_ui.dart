import '../app/app.locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

void setupSnackbarUi() {
  final service = locator<SnackbarService>();

  // Registers a config to be used when calling showSnackbar
  service.registerSnackbarConfig(
    SnackbarConfig(
      backgroundColor: Colors.grey,
      messageTextAlign: TextAlign.center,
      titleTextAlign: TextAlign.center,
      textColor: Colors.white70,
      titleColor: Colors.white70,
      messageColor: Colors.white70,
    ),
  );
}
