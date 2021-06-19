import 'package:flutter/material.dart';

Future<void> showAlertDialog(BuildContext builderContext, {title = "Alert", contentText = "Alert !", acceptText = "OK"}) async {
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
              onPressed: () => Navigator.of(context).pop(),
            ),
          ]);
    },
  );
}
