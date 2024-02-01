import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
            overflow: TextOverflow.ellipsis));

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

Widget favoriteButton(
  String productId,
) {
  final fir = FirebaseFirestore.instance.collection("products");
  String myDocId = FirebaseAuth.instance.currentUser!.email ?? "";

  return StreamBuilder(
      stream: fir.doc(productId).snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final productData = snapshot.data;
          List favorited = productData["favorited"];
          bool isFavorited = favorited.contains(myDocId);
          return IconButton(
              onPressed: () async {
                if (isFavorited) {
                  removeFavoriteItem(productId, context);
                } else {
                  addToFavorites(productId, context);
                }
              },
              icon: Icon(
                Icons.favorite,
                color: isFavorited
                    ? const Color.fromARGB(255, 255, 17, 0)
                    : Colors.grey,
              ));
        }
        return Center(
          child: CircularProgressIndicator(color: Colors.grey),
        );
      });
}

void addToFavorites(String productId, BuildContext context) async {
  try {
    String myDocId = FirebaseAuth.instance.currentUser!.email ?? "";
    final productDb = FirebaseFirestore.instance.collection("products");
    final userDb = FirebaseFirestore.instance.collection("users");

    final productData = await productDb.doc(productId).get();
    List favoriteList = productData.data()?["favorited"] ?? [];

    final myData = await userDb.doc(myDocId).get();
    List myFavoriteList = myData.data()?["my_favourites"] ?? [];
    myFavoriteList.add({
      "id": productId,
      "name": productData["name"],
      "price": productData["price"],
      "image": productData["images"][0],
    });

    await userDb.doc(myDocId).update({"my_favourites": myFavoriteList});
    favoriteList.add(myDocId);
    await productDb.doc(productId).update({"favorited": favoriteList});
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Oop's some error occured")));
  }
}

void removeFavoriteItem(String productId, BuildContext context) async {
  try {
    String myDocId = FirebaseAuth.instance.currentUser!.email ?? "";
    final productDb = FirebaseFirestore.instance.collection("products");
    final userDb = FirebaseFirestore.instance.collection("users");

    final productData = await productDb.doc(productId).get();
    List favoriteList = productData.data()!["favorited"];

    final myData = await userDb.doc(myDocId).get();
    List myFavoriteList = myData.data()!["my_favourites"];
    late Map itemToDelete;
    myFavoriteList.forEach((element) {
      if (element["id"] == productId) {
        itemToDelete = element;
      }
    });
    myFavoriteList.remove(itemToDelete);
    await userDb.doc(myDocId).update({"my_favourites": myFavoriteList});
    favoriteList.remove(myDocId);
    await productDb.doc(productId).update({"favorited": favoriteList});
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Oop's some error occured")));
  }
}
