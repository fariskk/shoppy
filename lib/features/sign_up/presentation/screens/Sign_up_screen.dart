import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppy/core/common/common_widgets.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

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
              myText(text: "Sign Up", size: 25, fontWeight: FontWeight.bold),
              myText(text: "Create an new account", color: Colors.grey),
              const SizedBox(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "User Name",
                    labelStyle: TextStyle(fontSize: 22, color: Colors.black)),
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
              TextField(
                decoration: InputDecoration(
                    labelText: " confirm Password",
                    labelStyle: TextStyle(fontSize: 22, color: Colors.black)),
              ),
              SizedBox(
                height: 10,
              ),
              myButton(() {
                context.go("/successScreen", extra: {
                  "message": "signup success",
                  "nextRout": "/homeScreen",
                  "buttonText": "Start Shopping"
                });
              }, Colors.black, "sign Up", 50,
                  MediaQuery.of(context).size.width - 50, 30,
                  textcolor: Colors.white),
              Row(
                children: [
                  Checkbox(value: false, onChanged: (value) {}),
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: myText(
                        size: 15,
                        text:
                            "By creating an a account you have to agree with our terms and conditions"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
