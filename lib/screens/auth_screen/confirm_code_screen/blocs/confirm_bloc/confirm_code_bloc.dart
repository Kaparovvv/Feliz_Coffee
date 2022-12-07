import 'package:feliz_coin/helper/catchException.dart';
import 'package:feliz_coin/models/confirm_response_model.dart';
import 'package:feliz_coin/screens/auth_screen/confirm_code_screen/blocs/confirm_bloc/confirm_code_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'confirm_code_event.dart';
part 'confirm_code_state.dart';

class ConfirmCodeBloc extends Bloc<ConfirmCodeEvent, ConfirmCodeState> {
  ConfirmCodeBloc() : super(ConfirmCodeInitial()) {
    on<ConfirmCodeEvent>(
      (event, emit) async {
        if (event is PostConfirmCodeEvent) {
          emit(LoadingConfirmCodeState());
          try {
            ConfirmResponseModel responseModel =
                await ConfirmRepository().confirmCode(
              code: event.code,
              email: event.email,
            );
            emit(
              LoadedConfirmCodeState(responseModel: responseModel),
            );
          } catch (e) {
            emit(
              ErrorConfirmCodeState(
                message: CatchException.convertException(e),
              ),
            );
          }
        }
      },
    );
  }
}
