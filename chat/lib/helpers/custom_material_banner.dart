import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

MaterialBanner customMaterialBanner({
  required String title,
  required String message,
  required ContentType contentType,
}) {
  return MaterialBanner(
    elevation: 0,
    backgroundColor: Colors.transparent,
    dividerColor: Colors.transparent,
    forceActionsBelow: true,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: contentType,
      inMaterialBanner: true,
    ),
    actions: const [SizedBox.shrink()],
  );
}
