part of 'signup_bloc.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

class OtpVerifiedState extends SignupState {}

class LoadingState extends SignupState {}

class SignupfaildState extends SignupState {}

class SignupsuccessState extends SignupState {}

class OtpVerificationFaildState extends SignupState {}
