import 'dart:async';

import 'package:aim_common/common.dart';
import 'package:aim_datas/datas.dart';
import 'package:aim_models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository transactionRepository;

  TransactionBloc({
    required this.transactionRepository,
  }) : super(TransactionStateInitial());

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    if (event is TransactionEventRequest) {
      yield TransactionStateFetchLoading();
      try {
        yield TransactionStateFetchSuccess(transactions: await transactionRepository.getTransactions(odataParams: event.oDataParams));
      } catch (_) {
        yield TransactionStateFetchError();
      }
    }
    if (event is TransactionEventModifyRequest) {
      yield TransactionStateModifyLoading();
      try {
        TransactionModel transaction;
        if (event.transactionModifyModel.transactionId > 0) {
          transaction = await transactionRepository.updateTransaction(event.transactionModifyModel);
        } else {
          transaction = await transactionRepository.addTransaction(event.transactionModifyModel);
        }
        yield TransactionStateModifySuccess(transaction: transaction);
      } on ATBaseException catch (ex) {
        yield TransactionStateModifyError(
          message:
              ex is BusinessException && ex.exception.validations.length > 0 ? ex.exception.validations.map((e) => e.message).join("\n") : ex.message,
        );
      }
    }
    if (event is TransactionEventDeleteRequest) {
      yield TransactionStateDeleteLoading();
      try {
        await transactionRepository.deleteTransaction(event.id);
        yield TransactionStateDeleteSuccess(id: event.id);
      } on ATBaseException catch (ex) {
        yield TransactionStateDeleteError(
          message:
              ex is BusinessException && ex.exception.validations.length > 0 ? ex.exception.validations.map((e) => e.message).join("\n") : ex.message,
        );
      }
    }
  }
}
