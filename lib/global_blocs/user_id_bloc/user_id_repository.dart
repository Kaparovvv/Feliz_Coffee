import 'package:feliz_coin/global_blocs/user_id_bloc/user_id_provider.dart';
import 'package:feliz_coin/models/user_id_model.dart';

class UserIdRepository {
  Future<UserIdModel> getUserId() {
    UserIdProvider provider = UserIdProvider();

    return provider.getUserId();
  }
}
