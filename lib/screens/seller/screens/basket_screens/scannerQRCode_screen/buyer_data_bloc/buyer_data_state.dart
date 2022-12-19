part of 'buyer_data_bloc.dart';

@immutable
abstract class BuyerDataState {}

class BuyerDataInitial extends BuyerDataState {}

class LoadingBuyerDataState extends BuyerDataState {}

class LoadedBuyerDataState extends BuyerDataState {
  final UserDataModel buyerDataModel;

  LoadedBuyerDataState({required this.buyerDataModel});
}

class ErrorBuyerDataState extends BuyerDataState {
  final CatchException message;

  ErrorBuyerDataState({required this.message});
}
