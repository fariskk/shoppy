import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppy/core/common/common_widgets.dart';
import 'package:shoppy/features/payment/bloc/payment_bloc.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({
    super.key,
  });

  TextEditingController _streetController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _DistrictController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _zipCodeController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: ImageIcon(
                  AssetImage("assets/icons/left-arrow.png"),
                  size: 35,
                ),
                onPressed: () {
                  context.pop();
                },
              ),
              SizedBox(
                height: 10,
              ),
              myText(
                  text: "Add Shipping Address",
                  size: 20,
                  fontWeight: FontWeight.bold),
              SizedBox(
                height: 25,
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
                    addressField(_streetController, "Enter Your Street name",
                        "Street :"),
                    addressField(
                        _cityController, "Enter Your City name", "city :"),
                    addressField(_DistrictController,
                        "Enter Your District name", "District :"),
                    addressField(
                        _stateController, "Enter Your State name", "state :"),
                    addressField(
                        _zipCodeController, "Enter Your Zip Code", "Zip :"),
                    addressField(_phoneNumberController,
                        "Enter Your Phone Number", "Phone :"),
                  ],
                ),
              ),
              Expanded(child: SizedBox()),
              Center(
                  child: myButton(() {
                if (_cityController.text.isNotEmpty &&
                    _phoneNumberController.text.isNotEmpty &&
                    _stateController.text.isNotEmpty &&
                    _streetController.text.isNotEmpty &&
                    _zipCodeController.text.isNotEmpty &&
                    _DistrictController.text.isNotEmpty) {
                  Map shippingAdress = {
                    "street": _streetController.text,
                    "city": _cityController.text,
                    "district": _DistrictController.text,
                    "state": _stateController.text,
                    "zip": _zipCodeController.text,
                    "phone": _phoneNumberController.text
                  };
                  context.read<PaymentBloc>().add(NextButtonClickedEvent(
                      context: context, address: shippingAdress));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Enter your address")));
                }
              }, Colors.black, "NEXT", 50,
                      MediaQuery.of(context).size.width - 50, 30,
                      textcolor: Colors.white)),
              SizedBox(
                height: 20,
              )
            ],
          ),
        )),
      ),
    );
  }

  TextField addressField(
      TextEditingController _controller, String hintText, prifixText) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: myText(text: "$prifixText", size: 20),
          ),
          border: InputBorder.none),
    );
  }
}
