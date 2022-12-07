import 'package:feliz_coin/screens/auth_screen/forgot_password/bloc/forgot_password_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordEvent>((event, emit) async {
      if (event is GetForgotPasswordEvent) {
        emit(ForgotPassLoadingState());
        try {
          await ForgotPassRepository().resetPassword(email: event.email);

          emit(ForgotPassSuccessState());
        } catch (e) {
          emit(ForgotPassErrorState('erorr'));
        }
      }
    });
  }
}
