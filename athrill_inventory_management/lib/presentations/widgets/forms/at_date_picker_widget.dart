import 'package:flutter/material.dart';

import 'package:aim/presentation_constants/presentation_contants_barrel.dart';

Future<DateTime> showDatePickerWidget(BuildContext buildContext, {DateTime? selectedDateTime, DateTime? firstDate, DateTime? lastDate}) async {
  final DateTime selected = selectedDateTime != null ? selectedDateTime : DateTime.now();
  final DateTime first = firstDate != null ? firstDate : DateTime(1000);
  final DateTime last = lastDate != null ? lastDate : DateTime(9999);

  DateTime? retVal = await showDatePicker(
      context: buildContext,
      initialDate: selected,
      firstDate: first,
      lastDate: last,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: AIMColors.primaryColor, secondary: AIMColors.secondaryColor, onSurface: Colors.black),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      });
  return retVal != null ? retVal : selected;
}
