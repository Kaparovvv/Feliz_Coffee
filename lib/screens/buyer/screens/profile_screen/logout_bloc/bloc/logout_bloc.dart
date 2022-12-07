import 'package:feliz_coin/commons/logout_user.dart';
import 'package:feliz_coin/helper/catchException.dart';
import 'package:feliz_coin/screens/buyer/screens/profile_screen/logout_bloc/bloc/logout_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitial()) {
    on<PostLogoutEvent>(
      (event, emit) async {
        emit(LoadingLogoutState());
        try {
          LogoutUser logoutUser = await LogoutRepository().logoutUser();
          emit(LoadedLogoutState(logoutUser: logoutUser));
        } catch (e) {
          emit(
            ErrorLogoutState(
              message: CatchException.convertException(e),
            ),
          );
        }
      },
    );
  }
}
