import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppy/core/common/common_widgets.dart';
import 'package:flutter/services.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/background_image2.jpg"))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                myButton(() {
                  HapticFeedback.mediumImpact();
                  context.go(
                    "/loginScreen",
                  );
                }, Colors.white, "Login", 50, screenWidth - 50, 30),
                myButton(() {
                  HapticFeedback.mediumImpact();
                  context.go(
                    "/signupScreen",
                  );
                }, Colors.transparent, "Sign Up", 50, screenWidth - 50, 30,
                    bordered: true, textcolor: Colors.white),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: shoppyText(Color.fromARGB(255, 254, 242, 200)),
          )
        ],
      ),
    );
  }
}
