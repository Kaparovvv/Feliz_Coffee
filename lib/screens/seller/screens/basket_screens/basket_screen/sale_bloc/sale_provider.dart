import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:feliz_coin/commons/sale_deleted.dart';
import 'package:feliz_coin/helper/api_requester.dart';
import 'package:feliz_coin/helper/catchException.dart';
import 'package:feliz_coin/helper/urls.dart';
import 'package:feliz_coin/models/create_sale_model.dart';

class SaleProvider {
  Future<CreateSaleModel> createSale({
    required int branchId,
    required int? clientId,
    required String? fromBalanceAmount,
    required bool? isSold,
  }) async {
    try {
      ApiRequester requester = ApiRequester();
      Response response = await requester.toPost(createSaleUrl(), body: {
        "branch": branchId,
        "client": clientId,
        "from_balance_amount": fromBalanceAmount ?? '0',
        "sold": isSold ?? false,
      });

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        CreateSaleModel createSaleModel =
            CreateSaleModel.fromJson(response.data);
        log(response.data.toString());

        return createSaleModel;
      } else {
        throw CatchException.convertException(response);
      }
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }

  Future<SaleDeleted> deleteSale({required String saleId}) async {
    try {
      ApiRequester requester = ApiRequester();
      Response response = await requester.toDelete('/v1/sale/sale/$saleId/');

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        SaleDeleted saleDeleted = SaleDeleted(isDelete: true);
        return saleDeleted;
      } else {
        throw CatchException.convertException(response);
      }
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }
}
