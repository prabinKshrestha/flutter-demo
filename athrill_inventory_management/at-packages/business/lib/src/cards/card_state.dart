part of 'card_bloc.dart';

@immutable
abstract class CardState {}

class CardStateInitial extends CardState {}

class CardStateFetchLoading extends CardState {}

class CardStateFetchSuccess extends CardState {
  final List<CardModel> cards;

  CardStateFetchSuccess({
    required this.cards,
  });
}

class CardStateFetchError extends CardState {}

class CardStateModifyLoading extends CardState {}

class CardStateModifySuccess extends CardState {
  final CardModel card;

  CardStateModifySuccess({
    required this.card,
  });
}

class CardStateModifyError extends CardState {
  final String message;

  CardStateModifyError({
    required this.message,
  });
}

class CardStateDeleteLoading extends CardState {}

class CardStateDeleteSuccess extends CardState {
  final int id;

  CardStateDeleteSuccess({
    required this.id,
  });
}

class CardStateDeleteError extends CardState {
  final String message;

  CardStateDeleteError({
    required this.message,
  });
}
