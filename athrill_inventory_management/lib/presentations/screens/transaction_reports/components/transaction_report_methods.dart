part of '../transaction_report_screen.dart';

class TransactionReportScreenMethods {
  static ODataParametersModel getODataParameters({required int userId, required DateTime startDateTime, required DateTime endDateTime}) {
    String startDate = startDateTime.toIsoString(includeTime: false);
    String endDate = endDateTime.add(const Duration(days: 1)).toIsoString(includeTime: false);
    String filter = 'CreatedById EQ $userId AND CreatedOn >= "$startDate" AND CreatedOn < "$endDate"';
    return ODataParametersModel(filter: filter);
  }
}
