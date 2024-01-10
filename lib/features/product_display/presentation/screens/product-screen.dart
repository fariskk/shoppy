import 'package:flexi_image_slider/flexi_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:shoppy/core/common/common_widgets.dart';
import 'package:shoppy/features/product_display/presentation/widgets/product_screen-widgets.dart';
import 'package:star_rating/star_rating.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          flexi_image_slider(
              indicatorPosition: IndicatorPosition.overImage,
              context: context,
              aspectRatio: 1 / 1,
              boxFit: BoxFit.cover,
              autoScroll: false,
              arrayImages: [
                "https://rukminim2.flixcart.com/image/832/832/xif0q/t-shirt/5/9/6/m-all-rbc-white-one-nb-nicky-boy-original-imagpycw749kqzdz.jpeg?q=70",
                "https://rukminim2.flixcart.com/image/832/832/xif0q/t-shirt/w/8/l/l-all-rbc-white-one-nb-nicky-boy-original-imagpyct8f5hhauz.jpeg?q=70",
                "https://rukminim2.flixcart.com/image/832/832/xif0q/t-shirt/4/2/c/s-all-rbc-one-nb-nicky-boy-original-imagpycxgmnxretx.jpeg?q=70",
                "https://rukminim2.flixcart.com/image/832/832/xif0q/t-shirt/8/3/7/l-all-rbc-white-one-nb-nicky-boy-original-imagpycbphvjfmk4.jpeg?q=70"
              ]),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height / 2 + 8,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      myText(
                          text: "Roller Rabbit",
                          fontWeight: FontWeight.bold,
                          size: 23),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          myText(
                              text: "Tot Dress", size: 17, color: Colors.grey),
                          myText(
                              text: "Available in stok",
                              size: 14,
                              color: Colors.green)
                        ],
                      ),
                      Row(
                        children: [
                          StarRating(
                            starSize: 22,
                            length: 5,
                            rating: 3,
                            color: Color.fromARGB(255, 255, 181, 7),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: myText(
                                  text: "(See 135 Reviews)",
                                  color: Colors.blue,
                                  size: 12))
                        ],
                      ),
                      Container(
                        height: 130,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                myText(
                                    text: "Size",
                                    fontWeight: FontWeight.bold,
                                    size: 20),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    sizeIcon("S", "M"),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    sizeIcon("M", "M"),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    sizeIcon("L", "M")
                                  ],
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              width: 45,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 3,
                                        offset: Offset(0, 3),
                                        color: Colors.grey)
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  colorIcon(Colors.white, Colors.black),
                                  colorIcon(Colors.black, Colors.black),
                                  colorIcon(Colors.green, Colors.black),
                                  colorIcon(Colors.red, Colors.black)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      myText(text: "Description", fontWeight: FontWeight.bold),
                      myText(
                          text:
                              "This is a very good quality procut made from good row materials.this produst is long lasting and durable",
                          size: 16,
                          color: Colors.grey),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  myText(
                      text: "\$452.8", fontWeight: FontWeight.bold, size: 22),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 1.8,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageIcon(
                          AssetImage(
                            "assets/icons/add-cart.png",
                          ),
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        myText(text: "Add to cart", color: Colors.white)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite),
              ))
        ]),
      ),
    );
  }
}
