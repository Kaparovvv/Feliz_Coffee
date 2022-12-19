import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:feliz_coin/helper/api_requester.dart';
import 'package:feliz_coin/helper/catchException.dart';
import 'package:feliz_coin/models/user_data_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BuyerDataProvider {
  Box buyerData = Hive.box('buyerDataBox');
  Future<UserDataModel> getBuyerData({required String buyerId}) async {
    try {
      log('BuyerDataProvider Buyer ID =========== $buyerId');
      ApiRequester requester = ApiRequester();
      Response response = await requester.toGet('/register/$buyerId/');

      if (response.statusCode == 200) {
        log("BuyerDataProvider ==================== ${response.data}");
        UserDataModel buyerDataModel = UserDataModel.fromJson(response.data);

        await buyerData.put('email', response.data['email']);
        await buyerData.put('username', response.data['username']);
        await buyerData.put('phone', response.data['phone']);
        await buyerData.put('cashbackAll', response.data['cashback_all']);
        return buyerDataModel;
      } else {
        throw CatchException.convertException(response);
      }
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }
}
