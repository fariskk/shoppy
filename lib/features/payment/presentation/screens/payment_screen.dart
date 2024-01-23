import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shoppy/core/common/common_widgets.dart';
import 'package:shoppy/features/home/presentation/widgets/home_screen_widgets.dart';
import 'package:shoppy/features/payment/bloc/payment_bloc.dart';
import 'package:shoppy/features/payment/presentation/widgets/payment_widgets.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen(
      {super.key,
      required this.amount,
      required this.myCart,
      required this.address});
  List myCart;
  double amount;
  Map address;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: ImageIcon(
                      AssetImage("assets/icons/left-arrow.png"),
                      size: 35,
                    )),
                SizedBox(
                  height: 10,
                ),
                myText(text: " Address", size: 20, fontWeight: FontWeight.bold),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 5,
                            color: const Color.fromARGB(255, 222, 221, 221))
                      ]),
                  child: Column(
                    children: [
                      addressWidget("Street", address["street"]),
                      addressWidget("City", address["city"]),
                      addressWidget("District", address["district"]),
                      addressWidget("State", address["state"]),
                      addressWidget("Zip", address["zip"]),
                      addressWidget("Phone", address["phone"]),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                myText(text: "Products", fontWeight: FontWeight.bold, size: 20),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount: myCart.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: myText(text: myCart[index]["name"]),
                          leading: Container(
                            height: 60,
                            width: 60,
                            child: Image.network(myCart[index]["image"]),
                          ),
                          subtitle: Row(
                            children: [
                              myText(
                                  text: "₹ ${myCart[index]["price"]}",
                                  fontWeight: FontWeight.bold),
                              Text(" Quantity :${myCart[index]["count"]}"),
                              Text(" color : "),
                              Container(
                                height: 10,
                                width: 10,
                                color: manageColor(myCart[index]["color"]),
                              )
                            ],
                          ),
                        );
                      }),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      myText(text: "Total : ₹ $amount"),
                      myButton(() {
                        context.read<PaymentBloc>().add(
                                PlaceOrderButtonClickedEvent(
                                    amount: amount,
                                    context: context,
                                    orderDetails: {
                                  "name": FirebaseAuth
                                          .instance.currentUser?.email ??
                                      "NO USER",
                                  "address": address,
                                  "status": "orderd",
                                  "items": myCart,
                                }));
                      }, Colors.black, "Place Order", 50,
                          MediaQuery.of(context).size.width - 200, 30,
                          textcolor: Colors.white),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row addressWidget(String title, String value) {
    return Row(
      children: [
        myText(
          text: "$title : ",
          fontWeight: FontWeight.bold,
        ),
        myText(text: value, color: Colors.grey)
      ],
    );
  }
}
