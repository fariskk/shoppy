part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class GoogleButtonClickedEvent extends LoginEvent {
  BuildContext context;
  GoogleButtonClickedEvent({required this.context});
}

class LoginButtonClickedEvent extends LoginEvent {
  BuildContext context;
  String Email;
  String password;
  LoginButtonClickedEvent(
      {required this.context, required this.password, required this.Email});
}
