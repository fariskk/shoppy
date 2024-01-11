part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

class SignupButtonClickedEvent extends SignupEvent {
  BuildContext context;
  String email;
  String password;
  SignupButtonClickedEvent(
      {required this.context, required this.email, required this.password});
}

class VerifyEmailButtonClickedEvent extends SignupEvent {
  BuildContext context;

  String userEmail;
  VerifyEmailButtonClickedEvent(
      {required this.context, required this.userEmail});
}

class VerifyButtonClickedEvent extends SignupEvent {
  BuildContext context;
  String otp;
  String userEmail;
  VerifyButtonClickedEvent(
      {required this.context, required this.otp, required this.userEmail});
}
