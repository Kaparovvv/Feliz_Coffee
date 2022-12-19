import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:feliz_coin/helper/api_requester.dart';
import 'package:feliz_coin/helper/catchException.dart';
import 'package:feliz_coin/models/user_data_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileProvider {
  Box userData = Hive.box('userDataBox');
  Future<UserDataModel> getProfile({required String userId}) async {
    try {
      ApiRequester requester = ApiRequester();
      Response response = await requester.toGet('/register/$userId/');

      if (response.statusCode == 200) {
        log("Pofile Data ==================== ${response.data}");
        UserDataModel userDataModel = UserDataModel.fromJson(response.data);

        await userData.put('email', response.data['email']);
        await userData.put('username', response.data['username']);
        await userData.put('phone', response.data['phone']);
        await userData.put('qrCode', response.data['qr_code']);
        await userData.put('cashbackAll', response.data['cashback_all']);
        await userData.put('isSeller', response.data['is_seller']);
        await userData.put('branchId', response.data['branch_user']);
        return userDataModel;
      } else {
        throw CatchException.convertException(response);
      }
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }
}
