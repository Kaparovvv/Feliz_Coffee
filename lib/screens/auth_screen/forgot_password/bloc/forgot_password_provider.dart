import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:feliz_coin/helper/api_requester.dart';
import 'package:feliz_coin/helper/catchException.dart';

class ForgotPassProvider {
  Future resetPassword({
    required String email,
  }) async {
    try {
      ApiRequester requester = ApiRequester();
      Response response =
          await requester.toPost('auth/users/reset_password', body: {
        "email": email,
      });
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        log(response.data.toString());
      } else {
        throw CatchException.convertException(response);
      }
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }
}
