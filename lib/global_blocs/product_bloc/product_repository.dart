import 'package:feliz_coin/global_blocs/product_bloc/product_provider.dart';
import 'package:feliz_coin/models/product_model.dart';

class ProductRepository {
  Future<List<ProductModel>> getProduct(int categoryId) {
    ProductProvider provider = ProductProvider();

    return provider.getProduct(categoryId);
  }
}
