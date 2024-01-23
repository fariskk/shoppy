import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppy/core/common/common_widgets.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key, required this.title, required this.searchId});
  String title;
  String searchId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 237, 252),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              myText(text: title, size: 22, fontWeight: FontWeight.bold),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("products")
                        .where("type", isEqualTo: searchId)
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        final docs = snapshot.data.docs;
                        if (docs.length == 0) {
                          return Center(
                            child: myText(text: "No items"),
                          );
                        }
                        return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemCount: docs.length,
                            itemBuilder: (context, index) {
                              Map categoryItem = docs[index].data();

                              return GestureDetector(
                                onTap: () {
                                  context.go("/homeScreen/productScreen",
                                      extra: {
                                        "product_id": categoryItem["id"],
                                        "offer_price": -1
                                      });
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.width / 2,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Column(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                66,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                30,
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 3),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  categoryItem["images"][0]),
                                              fit: BoxFit.cover),
                                        ),
                                        child: Align(
                                            alignment: Alignment.topRight,
                                            child: favoriteButton(
                                                categoryItem["id"])),
                                      ),
                                      myText(
                                          text: manageStringLength(
                                              categoryItem["name"]),
                                          size: 16,
                                          fontWeight: FontWeight.bold),
                                      myText(
                                          text: "₹ ${categoryItem["price"]}",
                                          size: 16)
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String manageStringLength(String text) {
    if (text.length > 15) {
      String newString = text.substring(0, 15);
      return "$newString...";
    }
    return text;
  }
}
