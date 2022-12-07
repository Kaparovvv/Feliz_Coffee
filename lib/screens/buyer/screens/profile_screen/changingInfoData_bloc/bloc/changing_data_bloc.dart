import 'package:feliz_coin/helper/catchException.dart';
import 'package:feliz_coin/screens/buyer/screens/profile_screen/changingInfoData_bloc/changingData_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'changing_data_event.dart';
part 'changing_data_state.dart';

class ChangingDataBloc extends Bloc<ChangingDataEvent, ChangingDataState> {
  ChangingDataBloc() : super(ChangingDataInitial()) {
    on<PatchChangingDataEvent>((event, emit) async {
      emit(LoadingChangingDataState());
      try {
        await ChangingDataRepository().patchUser(
          username: event.username,
          email: event.email,
          isSeller: event.isSeller,
          // phone: event.phone,
        );

        emit(LoadedChangingDataState());
      } catch (e) {
        print('Changing data bloc ===== $e');

        emit(
          ErrorChangingDataState(
            message: CatchException.convertException(e),
          ),
        );
      }
    });
  }
}
