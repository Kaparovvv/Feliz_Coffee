part of 'sale_product_bloc.dart';

@immutable
abstract class SaleProductEvent {}

class AddingProductToBasketEvent extends SaleProductEvent {
  final int saleId;
  final int productId;
  final int amount;

  AddingProductToBasketEvent({
    required this.saleId,
    required this.productId,
    required this.amount,
  });
}

class DeletingProductFromBasketEvent extends SaleProductEvent {
  final String saleProductId;

  DeletingProductFromBasketEvent({required this.saleProductId});
}
