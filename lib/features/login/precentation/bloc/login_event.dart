part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class GoogleButtonClickedEvent extends LoginEvent {
  BuildContext context;
  GoogleButtonClickedEvent({required this.context});
}
