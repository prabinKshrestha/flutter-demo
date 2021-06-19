part of 'transaction_bloc.dart';

@immutable
abstract class TransactionState {}

class TransactionStateInitial extends TransactionState {}

class TransactionStateFetchLoading extends TransactionState {}

class TransactionStateFetchSuccess extends TransactionState {
  final List<TransactionModel> transactions;

  TransactionStateFetchSuccess({
    required this.transactions,
  });
}

class TransactionStateFetchError extends TransactionState {}

class TransactionStateModifyLoading extends TransactionState {}

class TransactionStateModifySuccess extends TransactionState {
  final TransactionModel transaction;

  TransactionStateModifySuccess({
    required this.transaction,
  });
}

class TransactionStateModifyError extends TransactionState {
  final String message;

  TransactionStateModifyError({
    required this.message,
  });
}

class TransactionStateDeleteLoading extends TransactionState {}

class TransactionStateDeleteSuccess extends TransactionState {
  final int id;

  TransactionStateDeleteSuccess({
    required this.id,
  });
}

class TransactionStateDeleteError extends TransactionState {
  final String message;

  TransactionStateDeleteError({
    required this.message,
  });
}
