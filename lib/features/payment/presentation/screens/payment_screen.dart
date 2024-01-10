import 'package:flutter/material.dart';
import 'package:shoppy/core/common/common_widgets.dart';
import 'package:shoppy/features/payment/presentation/widgets/payment_widgets.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              myText(text: " Payment", size: 20, fontWeight: FontWeight.bold),
              SizedBox(
                height: 40,
              ),
              paymentTile(
                  "Credit Card", "assets/icons/credit-card.png", "Credit Card"),
              paymentTile("Upi payment", "assets/icons/online-payment.png",
                  "Credit Card"),
              paymentTile("Cash On delivery",
                  "assets/icons/cash-on-delivery.png", "Credit Card"),
              Expanded(
                child: SizedBox(
                  height: 30,
                ),
              ),
              myButton(() {}, Colors.black, "Proceed", 50,
                  MediaQuery.of(context).size.width - 50, 30,
                  textcolor: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}
