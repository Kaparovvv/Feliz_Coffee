import 'package:feliz_coin/commons/sale_deleted.dart';
import 'package:feliz_coin/models/create_sale_model.dart';
import 'package:feliz_coin/screens/seller/screens/basket_screens/basket_screen/sale_bloc/sale_provider.dart';

class SaleRepository {
  Future<CreateSaleModel> createSale({
    required int branchId,
    required int? clientId,
    required String? fromBalanceAmount,
    required bool? isSold,
  }) {
    SaleProvider provider = SaleProvider();

    return provider.createSale(
      branchId: branchId,
      clientId: clientId,
      fromBalanceAmount: fromBalanceAmount,
      isSold: isSold,
    );
  }

  Future<SaleDeleted> deleteSale({required String saleId}) {
    SaleProvider provider = SaleProvider();
    return provider.deleteSale(saleId: saleId);
  }
}
