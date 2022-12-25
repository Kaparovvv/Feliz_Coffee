import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'confirm_button_event.dart';
part 'confirm_button_state.dart';

class ConfirmButtonBloc extends Bloc<ConfirmButtonEvent, ConfirmButtonState> {
  ConfirmButtonBloc() : super(ConfirmButtonInitial()) {
    on<ConfirmButtonEvent>((event, emit) {
      if (event is SaleSuccessfulCreatedEvent) {
        emit(CreatedConfirmButtonsState());
      }
      if (event is SaleSuccessfulDeletedEvent) {
        emit(DeletedConfirmButtonsState());
      }
    });
  }
}
