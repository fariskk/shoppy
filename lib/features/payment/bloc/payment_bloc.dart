import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  String myDocid = FirebaseAuth.instance.currentUser!.email ?? "nouser";
  PaymentBloc() : super(PaymentInitial()) {
    on<ProceedToPaymentButtonClickedEvent>((event, emit) async {
      final fir = FirebaseFirestore.instance.collection("users");
      await fir.doc(myDocid).update({"address": event.shippingAddres});

      event.context.go("/homeScreen/addressScreen/paymentScreen", extra: {
        "amount": event.amount,
        "my_cart": event.myCart,
        "address": event.shippingAddres
      });
    });
    on<PlaceOrderButtonClickedEvent>((event, emit) async {
      final fir =
          FirebaseFirestore.instance.collection("company").doc("shoppy");
      final data = await fir.get();
      List orders = data.data()?["orders"] ?? [];

      try {
        Razorpay razorpay = Razorpay();
        var options = {
          'key': '',
          'amount': event.amount * 100,
          'name': 'Shoppy',
          'prefill': {'contact': '8888888888', 'email': 'shoppy@gmail.com'},
          'external': {
            'wallets': ['paytm']
          }
        };
        razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, () {
          throw "";
        });
        razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, () async {
          orders.add(event.orderDetails);
          await fir.update({"orders": orders});
          ScaffoldMessenger.of(event.context)
              .showSnackBar(SnackBar(content: Text("Payment success")));
        });
        razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, () {
          throw "";
        });
        razorpay.open(options);
      } catch (e) {
        ScaffoldMessenger.of(event.context)
            .showSnackBar(SnackBar(content: Text("Payment Faild")));
      }
    });
  }
}
