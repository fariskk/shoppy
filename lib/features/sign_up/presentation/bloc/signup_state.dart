part of 'signup_bloc.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

class OtpVerifiedState extends SignupState {}

class OtpVerificationFaildState extends SignupState {}
