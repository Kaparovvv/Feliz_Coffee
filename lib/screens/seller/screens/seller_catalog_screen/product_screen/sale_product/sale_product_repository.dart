import 'package:feliz_coin/commons/sale_deleted.dart';
import 'package:feliz_coin/models/sale_product_model.dart';
import 'package:feliz_coin/screens/seller/screens/seller_catalog_screen/product_screen/sale_product/sale_product_provider.dart';

class SaleProductRepository {
  SaleProductProvider provider = SaleProductProvider();

  Future<SaleProductModel> addingToBasket({
    required int saleId,
    required int productId,
    required int amount,
  }) {
    return provider.addingToBasket(
      saleId: saleId,
      productId: productId,
      amount: amount,
    );
  }

  Future<ProductDeletedFromBasket> deletingFromBasket(
      {required String saleProductId}) {
    return provider.deletingFromBasket(saleProductId: saleProductId);
  }
}
