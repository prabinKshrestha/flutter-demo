part of 'transaction_bloc.dart';

@immutable
abstract class TransactionEvent {}

class TransactionEventInitial extends TransactionEvent {}

class TransactionEventRequest extends TransactionEvent {
  final ODataParametersModel? oDataParams;

  TransactionEventRequest({
    this.oDataParams,
  });
}

class TransactionEventModifyRequest extends TransactionEvent {
  final TransactionModifyModel transactionModifyModel;

  TransactionEventModifyRequest({
    required this.transactionModifyModel,
  });
}

class TransactionEventDeleteRequest extends TransactionEvent {
  final int id;

  TransactionEventDeleteRequest({
    required this.id,
  });
}
