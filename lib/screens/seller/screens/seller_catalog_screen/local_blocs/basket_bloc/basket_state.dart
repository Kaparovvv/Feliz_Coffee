part of 'basket_bloc.dart';

@immutable
abstract class BasketState {}

class BasketInitial extends BasketState {}

class ProductInBasketState extends BasketState {}

class ProductIsNotBasketState extends BasketState {}
