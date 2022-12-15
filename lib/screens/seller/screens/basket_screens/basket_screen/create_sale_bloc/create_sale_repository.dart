import 'package:feliz_coin/models/create_sale_model.dart';
import 'package:feliz_coin/screens/seller/screens/basket_screens/basket_screen/create_sale_bloc/create_sale_provider.dart';

class CreateSaleRepository {
  Future<CreateSaleModel> createSale({
    required int branchId,
    required int? clientId,
    required String? fromBalanceAmount,
    required bool? isSold,
  }) {
    CreateSaleProvider provider = CreateSaleProvider();

    return provider.createSale(
      branchId: branchId,
      clientId: clientId,
      fromBalanceAmount: fromBalanceAmount,
      isSold: isSold,
    );
  }
}
