import 'package:flutter/material.dart';

Future<void> showConfirmationDialog(
  BuildContext builderContext, {
  title = "Please Confirm",
  contentText = "Are you sure that you want to perform this action ?",
  acceptText = "OK",
  declineText = "Cancel",
  required Function acceptCallBackFunction,
}) async {
  return await showDialog<void>(
    context: builderContext,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
          title: Text(title),
          titlePadding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
          content: SingleChildScrollView(child: Text(contentText)),
          contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
          contentTextStyle: TextStyle(fontSize: 15, color: Colors.black),
          actions: [
            TextButton(
              child: Text(acceptText),
              onPressed: () {
                acceptCallBackFunction();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(declineText),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ]);
    },
  );
}
