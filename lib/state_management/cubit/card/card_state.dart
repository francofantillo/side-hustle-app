part of 'card_cubit.dart';

class CardState {
  CardModel? cardModel;

  CardState({this.cardModel});

  CardState copyWith({CardModel? cardModel}) {
    return CardState(cardModel: cardModel ?? this.cardModel);
  }
}
