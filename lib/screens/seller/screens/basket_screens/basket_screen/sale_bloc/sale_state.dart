part of 'sale_bloc.dart';

@immutable
abstract class SaleState {}

class SaleInitial extends SaleState {}

class LoadingCreateSaleState extends SaleState {}

class LoadedCreateSaleState extends SaleState {
  final CreateSaleModel createSaleModel;

  LoadedCreateSaleState({required this.createSaleModel});
}

class ErrorSaleState extends SaleState {
  final CatchException message;

  ErrorSaleState({required this.message});
}

class LoadingDeleteSaleState extends SaleState {}

class LoadedDeleteSaleState extends SaleState {
  final SaleDeleted saleDeleted;

  LoadedDeleteSaleState({required this.saleDeleted});
}
