import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:feliz_coin/helper/api_requester.dart';
import 'package:feliz_coin/helper/catchException.dart';
import 'package:feliz_coin/models/resend_response_model.dart';

class ResendCodeProvider {
  Future<ResendResponseModel> resendCode({
    required String email,
  }) async {
    try {
      ApiRequester requester = ApiRequester();
      Response response = await requester
          .toPost('/register/resend_code/', isToken: false, body: {
        'email': email,
      });
      log(response.data.toString());
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        ResendResponseModel responseModel =
            ResendResponseModel.fromJson(response.data);

        return responseModel;
      } else {
        throw CatchException.convertException(response);
      }
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }
}
