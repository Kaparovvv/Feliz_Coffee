import 'package:feliz_coin/helper/catchException.dart';
import 'package:feliz_coin/models/sign_up_response_model.dart';
import 'package:feliz_coin/screens/auth_screen/sign_up_screen/bloc/sign_up_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) async {
      if (event is SignUpAuthEvent) {
        emit(LoadingSignUpState());
        try {
          SignUpResponseModel responseModel =
              await SignUpRepository().createUser(
            email: event.email,
            username: event.username,
            phoneNumber: event.phone,
            password: event.password,
          );
          emit(LoadedSignUpState(responseModel: responseModel));
        } catch (e) {
          emit(
            ErrorSignUpState(
              message: CatchException.convertException(e),
            ),
          );
        }
      }
    });
  }
}
