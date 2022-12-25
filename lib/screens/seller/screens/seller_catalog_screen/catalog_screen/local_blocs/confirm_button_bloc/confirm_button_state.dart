part of 'confirm_button_bloc.dart';

@immutable
abstract class ConfirmButtonState {}

class ConfirmButtonInitial extends ConfirmButtonState {}

class CreatedConfirmButtonsState extends ConfirmButtonState {}

class DeletedConfirmButtonsState extends ConfirmButtonState {}
