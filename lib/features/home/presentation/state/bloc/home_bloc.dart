import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    String myDocId = FirebaseAuth.instance.currentUser!.email ?? "nouser";
    on<QuantityIncreeseButtonClickedEvent>((event, emit) {
      final fir = FirebaseFirestore.instance.collection("users");
      event.myCart[event.index]["count"] = event.currentCount + 1;
      fir.doc(myDocId).update({"my_cart": event.myCart});
    });
    on<QuantitydecreeseButtonClickedEvent>((event, emit) {
      final fir = FirebaseFirestore.instance.collection("users");
      event.myCart[event.index]["count"] = event.currentCount - 1;
      fir.doc(myDocId).update({"my_cart": event.myCart});
    });
    on<DeleteCartItemButtonClickedEvent>((event, emit) async {
      final fir = FirebaseFirestore.instance.collection("users");
      event.myCart.removeAt(event.index);
      await fir.doc(myDocId).update({"my_cart": event.myCart});
    });
    on<ProceedToPaymentButtonClickedEvent>((event, emit) async {
      event.context.go("/homeScreen/paymentScreen", extra: {
        "amount": event.amount,
        "my_cart": event.myCart,
        "address": event.shippingAddres
      });
    });
  }
}
