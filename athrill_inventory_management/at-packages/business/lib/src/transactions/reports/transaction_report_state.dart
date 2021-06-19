part of 'transaction_report_bloc.dart';

@immutable
abstract class TransactionReportState {}

class TransactionReportStateInitial extends TransactionReportState {}

class TransactionReportStateFetchLoading extends TransactionReportState {}

class TransactionReportStateFetchSuccess extends TransactionReportState {
  final List<TransactionModel> transactions;

  TransactionReportStateFetchSuccess({
    required this.transactions,
  });
}

class TransactionReportStateFetchError extends TransactionReportState {}
