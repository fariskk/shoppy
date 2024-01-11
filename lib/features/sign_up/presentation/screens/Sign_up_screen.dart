import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppy/core/common/common_widgets.dart';
import 'package:shoppy/core/validator/signup_form_validator.dart';
import 'package:shoppy/features/sign_up/presentation/bloc/signup_bloc.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _passwordContrtoller = TextEditingController();
  final _conformPasswordController = TextEditingController();
  bool otpVisibility = false;

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
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(fontSize: 22, color: Colors.black),
                    suffixIcon: TextButton(
                      child: Text("Verify email"),
                      onPressed: () {
                        if (!_emailController.text.contains("@")) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Invalid email")));
                          return;
                        }
                        otpVisibility = true;
                        context.read<SignupBloc>().add(
                            VerifyEmailButtonClickedEvent(
                                context: context,
                                userEmail: _emailController.text));
                      },
                    )),
              ),
              BlocBuilder<SignupBloc, SignupState>(
                builder: (context, state) {
                  if (state is OtpVerifiedState) {
                    return SizedBox();
                  }
                  return Visibility(
                      visible: otpVisibility,
                      child: Row(
                        children: [
                          Container(
                            width: 150,
                            height: 50,
                            color: const Color.fromARGB(255, 233, 230, 230),
                            child: TextField(
                              controller: _otpController,
                              decoration: InputDecoration(
                                  hintText: " OTP", border: InputBorder.none),
                            ),
                          ),
                          myButton(() {
                            context
                                .read<SignupBloc>()
                                .add(VerifyButtonClickedEvent(
                                  userEmail: _emailController.text,
                                  context: context,
                                  otp: _otpController.text,
                                ));
                          }, Colors.white, "Verify", 50, 60, 0,
                              textcolor: Colors.green)
                        ],
                      ));
                },
              ),
              TextFormField(
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return SignupFormvalidator()
                      .validatePassword(_passwordContrtoller.text);
                },
                controller: _passwordContrtoller,
                decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(fontSize: 22, color: Colors.black)),
              ),
              TextFormField(
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return SignupFormvalidator().validateConformPassword(
                      _passwordContrtoller.text,
                      _conformPasswordController.text);
                },
                controller: _conformPasswordController,
                decoration: InputDecoration(
                    labelText: " confirm Password",
                    labelStyle: TextStyle(fontSize: 22, color: Colors.black)),
              ),
              SizedBox(
                height: 10,
              ),
              myButton(() {
                if (_passwordContrtoller.text.isNotEmpty &&
                    _conformPasswordController.text ==
                        _passwordContrtoller.text) {
                  context.read<SignupBloc>().add(SignupButtonClickedEvent(
                      context: context,
                      email: _emailController.text,
                      password: _passwordContrtoller.text));
                } else {}
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
