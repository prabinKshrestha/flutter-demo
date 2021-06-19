import 'dart:async';

import 'package:aim_datas/datas.dart';
import 'package:aim_models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'transaction_report_event.dart';
part 'transaction_report_state.dart';

class TransactionReportBloc extends Bloc<TransactionReportEvent, TransactionReportState> {
  final TransactionRepository transactionRepository;

  TransactionReportBloc({
    required this.transactionRepository,
  }) : super(TransactionReportStateInitial());

  @override
  Stream<TransactionReportState> mapEventToState(TransactionReportEvent event) async* {
    if (event is TransactionReportEventRequest) {
      yield TransactionReportStateFetchLoading();
      try {
        yield TransactionReportStateFetchSuccess(transactions: await transactionRepository.getTransactions(odataParams: event.oDataParams));
      } catch (_) {
        yield TransactionReportStateFetchError();
      }
    }
  }
}
