import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'my_order_event.dart';
part 'my_order_state.dart';

class MyOrderBloc extends Bloc<MyOrderEvent, MyOrderState> {
  MyOrderBloc() : super(MyOrderInitial()) {
    DateTime now = DateTime.now();
    on<AddREviewButtonClickedEvent>((event, emit) async {
      try {
        final fir = FirebaseFirestore.instance
            .collection("products")
            .doc(event.productId);
        final data = await fir.get();
        List reviews = data.data()!["reviews"];
        int rating = 0;
        reviews.add({
          "name": FirebaseAuth.instance.currentUser!.email,
          "data": "${now.day}-${now.month}-${now.year}",
          "rating": event.rating,
          "comment": event.comment
        });
        double totalRating = 0;
        reviews.forEach((element) {
          totalRating += element["rating"];
        });
        rating = (totalRating / reviews.length).round();

        await fir.update({"reviews": reviews, "rating": rating});
      } catch (e) {}
    });
  }
}
