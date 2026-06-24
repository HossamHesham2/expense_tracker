import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  final String title;
  final String message;
  final ContentType contentType;

  CustomSnackBar({
    required this.title,
    required this.message,
    required this.contentType,
  });

  SnackBar get snackBar {
    return SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
      ),
    );
  }
}