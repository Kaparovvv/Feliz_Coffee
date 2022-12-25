import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:feliz_coin/commons/sale_deleted.dart';
import 'package:feliz_coin/helper/api_requester.dart';
import 'package:feliz_coin/helper/catchException.dart';
import 'package:feliz_coin/helper/urls.dart';
import 'package:feliz_coin/models/sale_product_model.dart';

class SaleProductProvider {
  Future<SaleProductModel> addingToBasket({
    required int saleId,
    required int productId,
    required int? amount,
  }) async {
    try {
      ApiRequester requester = ApiRequester();
      Response response =
          await requester.toPost(productAddToBasketUrl(), body: {
        "sale": saleId,
        "product": productId,
        "amount": amount ?? 1,
      });

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        SaleProductModel saleProductModel =
            SaleProductModel.fromJson(response.data);
        log(response.data.toString());
        return saleProductModel;
      } else {
        throw CatchException.convertException(response);
      }
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }

  Future<ProductDeletedFromBasket> deletingFromBasket({
    required String saleProductId,
  }) async {
    try {
      ApiRequester requester = ApiRequester();
      Response response =
          await requester.toDelete(removeProductFromBasketUrl(saleProductId));

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        ProductDeletedFromBasket isDeleted =
            ProductDeletedFromBasket(isDeleted: true);
        log(response.data.toString());
        return isDeleted;
      } else {
        throw CatchException.convertException(response);
      }
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }
}
