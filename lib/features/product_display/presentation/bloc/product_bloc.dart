import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shoppy/core/common/common_widgets.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ReloadEvent>((event, emit) {
      emit(ProductInitial());
    });
    on<AddToCartButtonClickedEvent>((event, emit) async {
      try {
        String myDocid = FirebaseAuth.instance.currentUser!.email ?? "nouser";
        final fir = FirebaseFirestore.instance.collection("users");
        final data = await fir.doc(myDocid).get();
        List myCart = data.data()?["my_cart"] ?? [];
        myCart.add(event.productDetails);
        fir.doc(myDocid).update({"my_cart": myCart});
        ScaffoldMessenger.of(event.context)
            .showSnackBar(SnackBar(content: Text("Product added to cart")));
      } catch (e) {
        ScaffoldMessenger.of(event.context).showSnackBar(
            SnackBar(content: Text("Some error occured,try again")));
      }
    });
  }
}
