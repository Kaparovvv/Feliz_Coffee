import 'package:feliz_coin/global_blocs/user_data_bloc/profile_provider.dart';
import 'package:feliz_coin/models/user_data_model.dart';

class ProfileRepository {
  Future<UserDataModel> getProfile({required int userId}) {
    ProfileProvider profileProvider = ProfileProvider();

    return profileProvider.getProfile(userId: userId);
  }
}
