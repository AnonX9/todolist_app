import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

Map<String, dynamic> options = {
  "success": "Congrats !",
  "error": "Oh Snap !",
};

SnackBar getSnackBar(String option, String message) {
  return SnackBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    behavior: SnackBarBehavior.floating,
    content: AwesomeSnackbarContent(
      title: options[option]["title"],
      message: message,
      contentType:
          option == "success" ? ContentType.success : ContentType.failure,
      messageFontSize: 14,
    ),
  );
}
