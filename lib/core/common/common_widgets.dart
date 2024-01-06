import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget shoppyText(Color textColor) => Text(
      "Shoppy",
      style: GoogleFonts.dancingScript(color: textColor, fontSize: 70),
    );

Widget myText(
        {required String text,
        double size = 18,
        Color color = Colors.black,
        FontWeight fontWeight = FontWeight.normal}) =>
    Text(text,
        style: TextStyle(
          fontSize: size,
          color: color,
          fontWeight: fontWeight,
        ));

Widget myButton(Function onPressed, Color backGroundColor, String text,
    double height, double width, double borderRadius,
    {bool bordered = false,
    Color textcolor = Colors.black,
    IconData? icon,
    Color iconColor = Colors.black}) {
  return InkWell(
    splashColor: Colors.transparent,
    onTap: () {
      onPressed();
    },
    child: Center(
      child: Container(
        margin: EdgeInsets.all(10),
        height: height,
        width: width,
        decoration: BoxDecoration(
            border: bordered ? Border.all(color: Colors.white, width: 2) : null,
            color: backGroundColor,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon != null
                ? Icon(
                    icon,
                    color: iconColor,
                  )
                : const SizedBox(),
            SizedBox(
              width: 5,
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: textcolor),
            ),
          ],
        ),
      ),
    ),
  );
}
