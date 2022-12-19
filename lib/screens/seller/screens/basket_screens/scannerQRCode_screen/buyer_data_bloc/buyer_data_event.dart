part of 'buyer_data_bloc.dart';

@immutable
abstract class BuyerDataEvent {}

class GetBuyerDataEvent extends BuyerDataEvent {
  final String buyerId;

  GetBuyerDataEvent({required this.buyerId});
}
