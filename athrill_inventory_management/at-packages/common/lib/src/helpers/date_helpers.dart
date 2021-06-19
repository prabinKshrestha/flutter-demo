import 'package:intl/intl.dart';

class DateHelper {}

extension DateTimeExtensions on DateTime {
  String format(String format) {
    return DateFormat(format).format(this);
  }

  DateTime removeTimeParameters() {
    return DateTime(this.year, this.month, this.day);
  }

  ///Converts DateTime to ISO format | UTC Date with time if [includeTime] is true or without time if false
  String toIsoString({bool includeTime = true}) {
    if (includeTime) {
      return this.toIso8601String();
    } else {
      return DateTime(this.year, this.month, this.day).toIso8601String();
    }
  }
}
