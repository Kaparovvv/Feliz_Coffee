part of 'sale_bloc.dart';

@immutable
abstract class SaleEvent {}

class PostCreateSaleEvent extends SaleEvent {
  final int branchId;
  final int? clientId;
  final String? fromBalanceAmount;
  final bool? isSold;

  PostCreateSaleEvent({
    required this.branchId,
    required this.clientId,
    required this.fromBalanceAmount,
    required this.isSold,
  });
}

class DeleteSaleEvent extends SaleEvent {
  final String saleId;

  DeleteSaleEvent({required this.saleId});
}
