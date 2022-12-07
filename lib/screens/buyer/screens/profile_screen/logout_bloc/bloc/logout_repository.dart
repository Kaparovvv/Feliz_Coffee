import 'package:feliz_coin/commons/logout_user.dart';
import 'package:feliz_coin/screens/buyer/screens/profile_screen/logout_bloc/bloc/logout_provider.dart';

class LogoutRepository {
  Future<LogoutUser> logoutUser() async {
    LogoutProvider provider = LogoutProvider();
    return provider.logoutUser();
  }
}
