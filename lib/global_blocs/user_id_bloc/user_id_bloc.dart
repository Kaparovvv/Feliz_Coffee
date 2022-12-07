import 'package:bloc/bloc.dart';
import 'package:feliz_coin/global_blocs/user_id_bloc/user_id_repository.dart';
import 'package:feliz_coin/helper/catchException.dart';
import 'package:feliz_coin/models/user_id_model.dart';
import 'package:meta/meta.dart';

part 'user_id_event.dart';
part 'user_id_state.dart';

class UserIdBloc extends Bloc<UserIdEvent, UserIdState> {
  UserIdBloc() : super(UserIdInitial()) {
    on<GetUserIdEvent>((event, emit) async {
      emit(LoadingUserIdState());
      try {
        UserIdModel userIdModel = await UserIdRepository().getUserId();

        emit(
          LoadedUserIdState(userIdModel: userIdModel),
        );
      } catch (e) {
        emit(
          ErrorUserIdState(
            message: CatchException.convertException(e),
          ),
        );
      }
    });
  }
}
