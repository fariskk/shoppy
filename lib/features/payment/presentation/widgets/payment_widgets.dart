import 'package:flutter/material.dart';
import 'package:shoppy/core/common/common_widgets.dart';

Card paymentTile(String title, String image, String selectedPayment) {
  return Card(
    elevation: 3,
    child: ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: title == selectedPayment ? Colors.black : Colors.white,
      title: myText(
          text: title,
          color: title == selectedPayment ? Colors.white : Colors.black),
      leading: ImageIcon(
        AssetImage(image),
        color: title == selectedPayment ? Colors.white : Colors.black,
      ),
      trailing: Container(
        height: 15,
        width: 15,
        decoration: BoxDecoration(
            color: title == selectedPayment ? Colors.black : Colors.white,
            border: Border.all(
                color: title == selectedPayment ? Colors.white : Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(15))),
      ),
    ),
  );
}
