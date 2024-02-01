import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_sender/email_sender.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  int? genarateOtp;
  String? verifiedEmail;
  SignupBloc() : super(SignupInitial()) {
    on<VerifyEmailButtonClickedEvent>((event, emit) async {
      emit(SignupInitial());
      Random random = Random();
      int randomNumber = random.nextInt(9000) + 999;

      EmailSender emailsender = EmailSender();
      try {
        var response = await emailsender.sendMessage(
            event.userEmail,
            "Shoopy",
            "Verification OTP",
            "Yor OTP to verify your email is $randomNumber");
        genarateOtp = randomNumber;
        ScaffoldMessenger.of(event.context)
            .showSnackBar(SnackBar(content: Text("OTP has been send")));
      } catch (e) {
        ScaffoldMessenger.of(event.context)
            .showSnackBar(SnackBar(content: Text("Faild to send OTP")));
      }
    });
    on<VerifyButtonClickedEvent>((event, emit) async {
      if (genarateOtp.toString() == event.otp) {
        verifiedEmail = event.userEmail;
        ScaffoldMessenger.of(event.context)
            .showSnackBar(SnackBar(content: Text("Email verified")));
        emit(OtpVerifiedState());
      } else {
        ScaffoldMessenger.of(event.context)
            .showSnackBar(SnackBar(content: Text("OTP verification Faild")));
      }
    });

    on<SignupButtonClickedEvent>((event, emit) async {
      try {
        emit(LoadingState());
        final fir = FirebaseFirestore.instance.collection("users");

        if (verifiedEmail != null) {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: verifiedEmail!, password: event.password);
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: verifiedEmail!, password: event.password);
          await fir.doc(event.email).set({
            "email": verifiedEmail,
            "my_orders": [],
            "my_favourites": [],
            "my_cart": [],
            "address": {}
          });
          ScaffoldMessenger.of(event.context)
              .showSnackBar(SnackBar(content: Text("Logged in Successfully")));
          event.context.go("/homeScreen");
          emit(SignupsuccessState());
        } else {
          emit(SignupfaildState());
          ScaffoldMessenger.of(event.context).showSnackBar(
              SnackBar(content: Text("  Plaease verify your email")));
        }
      } on FirebaseAuthException catch (e) {
        verifiedEmail = null;
        emit(SignupfaildState());
        ScaffoldMessenger.of(event.context)
            .showSnackBar(SnackBar(content: Text(e.message ?? e.code)));
      }
    });
  }
}
