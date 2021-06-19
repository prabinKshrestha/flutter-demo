import 'dart:async';

import 'package:aim_common/common.dart';
import 'package:aim_datas/datas.dart';
import 'package:aim_models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final CardRepository cardRepository;

  CardBloc({
    required this.cardRepository,
  }) : super(CardStateInitial());

  @override
  Stream<CardState> mapEventToState(CardEvent event) async* {
    if (event is CardEventFetchRequest) {
      yield CardStateFetchLoading();
      try {
        yield CardStateFetchSuccess(cards: await cardRepository.getCards(odataParams: event.oDataParams));
      } catch (_) {
        yield CardStateFetchError();
      }
    }
    if (event is CardEventModifyRequest) {
      yield CardStateModifyLoading();
      try {
        CardModel card;
        if (event.cardModifyModel.cardId > 0) {
          card = await cardRepository.updateCard(event.cardModifyModel);
        } else {
          card = await cardRepository.addCard(event.cardModifyModel);
        }
        yield CardStateModifySuccess(card: card);
      } on ATBaseException catch (ex) {
        yield CardStateModifyError(
          message:
              ex is BusinessException && ex.exception.validations.length > 0 ? ex.exception.validations.map((e) => e.message).join("\n") : ex.message,
        );
      }
    }
    if (event is CardEventDeleteRequest) {
      yield CardStateDeleteLoading();
      try {
        await cardRepository.deleteCard(event.id);
        yield CardStateDeleteSuccess(id: event.id);
      } on ATBaseException catch (ex) {
        yield CardStateDeleteError(
          message:
              ex is BusinessException && ex.exception.validations.length > 0 ? ex.exception.validations.map((e) => e.message).join("\n") : ex.message,
        );
      }
    }
  }
}
