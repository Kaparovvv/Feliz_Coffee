import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:feliz_coin/helper/api_requester.dart';
import 'package:feliz_coin/helper/catchException.dart';
import 'package:feliz_coin/helper/urls.dart';
import 'package:feliz_coin/models/create_sale_model.dart';

class CreateSaleProvider {
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
}
