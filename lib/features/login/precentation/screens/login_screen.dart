import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppy/core/common/common_widgets.dart';
import 'package:shoppy/features/home/presentation/screens/home_screen.dart';
import 'package:shoppy/features/home/presentation/widgets/home_screen_widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.center, child: shoppyText(Colors.black)),
              const SizedBox(
                height: 30,
              ),
              myText(text: "Welcome!", size: 35, fontWeight: FontWeight.bold),
              myText(text: "please login to continue", color: Colors.grey),
              const SizedBox(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(fontSize: 22, color: Colors.black)),
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(fontSize: 22, color: Colors.black)),
              ),
              SizedBox(
                height: 10,
              ),
              myButton(() {}, Colors.black, "Login", 50,
                  MediaQuery.of(context).size.width - 50, 30,
                  textcolor: Colors.white),
              myButton(
                  () {},
                  Color.fromRGBO(0, 74, 177, 1),
                  "Continue with facebook",
                  50,
                  MediaQuery.of(context).size.width - 50,
                  30,
                  textcolor: Colors.white,
                  icon: Icons.facebook,
                  iconColor: Colors.white),
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {},
                child: Center(
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        border: Border.all(
                          color: Colors.grey,
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/google_logo.png",
                          height: 22,
                          width: 22,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        myText(
                            text: "continue with Google",
                            size: 18,
                            fontWeight: FontWeight.bold),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 17),
                      )))
            ],
          ),
        ),
      ),
    ));
  }
}
