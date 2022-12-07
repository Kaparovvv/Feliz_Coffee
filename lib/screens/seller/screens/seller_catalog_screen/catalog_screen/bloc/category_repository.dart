import 'package:feliz_coin/models/category_seller_model.dart';
import 'package:feliz_coin/screens/seller/screens/seller_catalog_screen/catalog_screen/bloc/category_provider.dart';

class CategoryRepository {
  Future<CategorySellerModel> getCategory() async {
    CategoryProvider categoryProvider = CategoryProvider();

    return categoryProvider.getCategory();
  }
}
