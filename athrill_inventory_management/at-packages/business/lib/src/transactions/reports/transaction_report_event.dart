part of 'transaction_report_bloc.dart';

@immutable
abstract class TransactionReportEvent {}

class TransactionReportEventInitial extends TransactionReportEvent {}

class TransactionReportEventRequest extends TransactionReportEvent {
  final ODataParametersModel? oDataParams;

  TransactionReportEventRequest({
    this.oDataParams,
  });
}
