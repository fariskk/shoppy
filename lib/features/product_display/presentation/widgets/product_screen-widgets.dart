import 'package:flutter/material.dart';
import 'package:shoppy/core/common/common_widgets.dart';

Container colorIcon(Color color, Color selectedColor) {
  return Container(
    height: 30,
    width: 30,
    decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(30))),
    child: Center(
      child: color == selectedColor
          ? Icon(
              Icons.done,
              color: Colors.grey,
            )
          : null,
    ),
  );
}

Container sizeIcon(String letter, String selectedSize) {
  return Container(
    height: 40,
    width: 40,
    decoration: BoxDecoration(
        color: letter == selectedSize ? Colors.black : Colors.white,
        border: Border.all(
            width: 1.5, color: const Color.fromARGB(255, 221, 220, 220)),
        borderRadius: BorderRadius.all(Radius.circular(30))),
    child: Center(
      child: myText(
          text: letter,
          size: 25,
          color: letter == selectedSize ? Colors.white : Colors.black),
    ),
  );
}
