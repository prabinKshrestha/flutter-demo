import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common.dart';

class ApplicationHelper {
  static void copyToClipBoard(BuildContext context, String textToCopy, {String title = ''}) async {
    await Clipboard.setData(ClipboardData(text: textToCopy));
    showSnackBar(context, 'Copied $title');
  }

  static void showSnackBar(BuildContext context, String message, {int seconds = 2}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: seconds),
      ),
    );
  }

  static String getFullNetworkFilePath(String trailingPath) {
    return "${AppConstant.TOTAL_BASE_URL}/$trailingPath";
  }
}
