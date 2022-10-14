import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:utopia_recruitment_task/config/custom_theme.dart';

class CustomMessager {
  void showError({
    required BuildContext context,
    required String message,
    duration = const Duration(seconds: 5),
  }) {
    Flushbar(
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: CustomTheme.red,
      message: message,
      messageColor: CustomTheme.white,
      icon: const Icon(
        Icons.error_outline_rounded,
        size: 28.0,
        color: CustomTheme.white,
      ),
      duration: duration,
    ).show(context);
  }
}
