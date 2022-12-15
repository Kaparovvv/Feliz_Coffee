part of 'basket_bloc.dart';

@immutable
abstract class BasketEvent {}

class AddProductToBasketEvent extends BasketEvent {}

class DeleteProductFromBasketEvent extends BasketEvent {
  // final List<BasketModel> basketModel;

  // DeleteProductFromBasketEvent({
  //   required this.basketModel,
  // });
}

class GetProductInBasketEvent extends BasketEvent {}
