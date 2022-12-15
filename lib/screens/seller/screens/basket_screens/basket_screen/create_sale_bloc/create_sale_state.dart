part of 'create_sale_bloc.dart';

@immutable
abstract class CreateSaleState {}

class CreateSaleInitial extends CreateSaleState {}

class LoadingCreateSaleState extends CreateSaleState {}

class LoadedCreateSaleState extends CreateSaleState {
  final CreateSaleModel createSaleModel;

  LoadedCreateSaleState({required this.createSaleModel});
}

class ErrorCreateSaleState extends CreateSaleState {
  final CatchException message;

  ErrorCreateSaleState({required this.message});
}
