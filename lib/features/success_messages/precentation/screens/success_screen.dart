import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppy/core/common/common_widgets.dart';

class SuccessScreen extends StatelessWidget {
  SuccessScreen(
      {super.key,
      required this.message,
      required this.nextRout,
      required this.buttonText});
  String message;
  String nextRout;
  String buttonText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: SizedBox()),
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 120,
            ),
            myText(text: "successful!", size: 26),
            myText(text: message, size: 19, color: Colors.grey),
            Expanded(child: SizedBox()),
            myButton(() {
              HapticFeedback.mediumImpact();
              context.go(nextRout);
            }, Colors.black, buttonText, 50,
                MediaQuery.of(context).size.width - 50, 30,
                textcolor: Colors.white),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
