import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shoppy/core/common/common_widgets.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              myText(text: "Bags", size: 22, fontWeight: FontWeight.bold),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Container(
                        height: MediaQuery.of(context).size.width / 2,
                        width: MediaQuery.of(context).size.width / 2,
                        child: Column(
                          children: [
                            Container(
                              height:
                                  MediaQuery.of(context).size.width / 2 - 66,
                              width: MediaQuery.of(context).size.width / 2 - 30,
                              margin: EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/image2.jpg"),
                                    fit: BoxFit.cover),
                              ),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                            myText(
                                text: "Carter Bag",
                                size: 16,
                                fontWeight: FontWeight.bold),
                            myText(text: "\$54.6", size: 16)
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
