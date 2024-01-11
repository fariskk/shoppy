import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<GoogleButtonClickedEvent>((event, emit) async {
      emit(LoadingState());
      try {
        GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
        final fir = FirebaseFirestore.instance.collection("users");
        await FirebaseAuth.instance.signInWithProvider(_googleAuthProvider);
        String email = FirebaseAuth.instance.currentUser!.email!;
        fir.doc(email).get().then((value) {
          if (!value.exists) {
            print("exists");
            fir.doc(email).set({
              "email": email,
              "my_orders": ["test2"],
              "my_favourites": []
            });
          }
        });

        ScaffoldMessenger.of(event.context)
            .showSnackBar(SnackBar(content: Text("Logged in Successfully")));
        event.context.go("/homeScreen");
        emit(LoginSuccessState());
      } catch (e) {
        print("**********///////////////**************");
        print(e);
        emit(LoginSFaildState());
      }
    });
  }
}
