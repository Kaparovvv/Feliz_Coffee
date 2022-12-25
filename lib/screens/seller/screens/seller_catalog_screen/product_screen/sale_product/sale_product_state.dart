part of 'sale_product_bloc.dart';

@immutable
abstract class SaleProductState {}

class SaleProductInitial extends SaleProductState {}

class AddingProductToBasketState extends SaleProductState {}

class AddedProductToBasketState extends SaleProductState {
  final SaleProductModel saleProductModel;

  AddedProductToBasketState({required this.saleProductModel});
}

class DeletingProductFromBasketState extends SaleProductState {}

class DeletedProductFromBasketState extends SaleProductState {
  final ProductDeletedFromBasket isDeleted;

  DeletedProductFromBasketState({required this.isDeleted});
}

class ErrorSaleProductState extends SaleProductState {
  final CatchException message;

  ErrorSaleProductState({required this.message});
}
