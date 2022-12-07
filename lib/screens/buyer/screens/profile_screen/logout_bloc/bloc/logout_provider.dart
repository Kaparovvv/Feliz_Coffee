import 'package:feliz_coin/commons/logout_user.dart';
import 'package:feliz_coin/helper/api_requester.dart';
import 'package:feliz_coin/helper/catchException.dart';
import 'package:feliz_coin/helper/urls.dart';
import 'package:dio/dio.dart';

class LogoutProvider {
  Future<LogoutUser> logoutUser() async {
    try {
      ApiRequester requester = ApiRequester();
      Response response =
          await requester.toPost(logoutUserUrl(), isToken: true, body: {});

      if (response.statusCode! == 204) {
        LogoutUser logoutUser = LogoutUser(isLogout: true);
        return logoutUser;
      } else {
        throw CatchException.convertException(response);
      }
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }
}
