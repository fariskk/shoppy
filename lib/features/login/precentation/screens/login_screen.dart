import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppy/core/common/common_widgets.dart';
import 'package:shoppy/features/home/presentation/screens/home_screen.dart';
import 'package:shoppy/features/home/presentation/widgets/home_screen_widgets.dart';
import 'package:shoppy/features/login/precentation/bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(fontSize: 22, color: Colors.black)),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(fontSize: 22, color: Colors.black)),
              ),
              SizedBox(
                height: 10,
              ),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return loginLoadingButton(context);
                  }
                  return myButton(() {
                    context.read<LoginBloc>().add(LoginButtonClickedEvent(
                        context: context,
                        password: _passwordController.text,
                        Email: _emailController.text));
                  }, Colors.black, "Login", 50,
                      MediaQuery.of(context).size.width - 50, 30,
                      textcolor: Colors.white);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.all(10),
                      width: 50,
                      height: 1,
                      color: Colors.grey),
                  myText(text: "Or"),
                  Container(
                      margin: EdgeInsets.all(10),
                      width: 50,
                      height: 1,
                      color: Colors.grey)
                ],
              ),
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
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is GoogleLoadingState) {
                    return loginLoadingButton(context);
                  }
                  return googleLogiinButton(context);
                },
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                      onPressed: () {
                        context.go("/signupScreen");
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(fontSize: 17),
                      )))
            ],
          ),
        ),
      ),
    ));
  }

  InkWell googleLogiinButton(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () async {
        context
            .read<LoginBloc>()
            .add(GoogleButtonClickedEvent(context: context));
      },
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
    );
  }

  //Loding button

  Container loginLoadingButton(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width - 50,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Center(
        child: CircularProgressIndicator(color: Colors.black),
      ),
    );
  }
}
