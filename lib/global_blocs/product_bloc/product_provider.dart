import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:feliz_coin/helper/api_requester.dart';
import 'package:feliz_coin/helper/catchException.dart';
import 'package:feliz_coin/models/product_model.dart';

class ProductProvider {
  Future<List<ProductModel>> getProduct(int categoryId) async {
    Map<String, int> queryParam = {"category__id": categoryId};
    try {
      ApiRequester requester = ApiRequester();

      Response response = await requester.toGet(
        '/v1/products/product/',
        queryParam: queryParam,
      );

      if (response.statusCode == 200) {
        List<ProductModel> listOfProduct = response.data
            .map<ProductModel>((el) => ProductModel.fromJson(el))
            .toList();

        return listOfProduct;
      } else {
        throw CatchException.convertException(response);
      }
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }
}
