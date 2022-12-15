part of 'create_sale_bloc.dart';

@immutable
abstract class CreateSaleEvent {}

class PostCreateSaleEvent extends CreateSaleEvent {
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
