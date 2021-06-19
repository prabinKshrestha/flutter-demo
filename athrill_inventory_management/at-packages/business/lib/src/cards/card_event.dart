part of 'card_bloc.dart';

@immutable
abstract class CardEvent {}

class CardEventInitial extends CardEvent {}

class CardEventFetchRequest extends CardEvent {
  final ODataParametersModel? oDataParams;

  CardEventFetchRequest({
    this.oDataParams,
  });
}

class CardEventModifyRequest extends CardEvent {
  final CardModifyModel cardModifyModel;

  CardEventModifyRequest({
    required this.cardModifyModel,
  });
}

class CardEventDeleteRequest extends CardEvent {
  final int id;

  CardEventDeleteRequest({
    required this.id,
  });
}
