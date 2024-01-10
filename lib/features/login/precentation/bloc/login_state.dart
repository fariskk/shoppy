part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoadingState extends LoginState {}

class LoginSFaildState extends LoginState {}
