part of 'confirm_button_bloc.dart';

@immutable
abstract class ConfirmButtonEvent {}

class SaleSuccessfulCreatedEvent extends ConfirmButtonEvent {}

class SaleSuccessfulDeletedEvent extends ConfirmButtonEvent {}
