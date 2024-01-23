import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flexi_image_slider/flexi_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppy/core/common/common_widgets.dart';
import 'package:shoppy/features/product_display/presentation/bloc/product_bloc.dart';
import 'package:shoppy/features/product_display/presentation/widgets/product_screen-widgets.dart';
import 'package:star_rating/star_rating.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen(
      {super.key, required this.productId, required this.offersPrice});
  String productId;
  int offersPrice;
  String selectedSize = "M";
  Color selectedColor = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getProductDetails(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map productDetails = snapshot.data;
              List<String> images =
                  List<String>.from(productDetails["images"] as List);
              List reviews = productDetails["reviews"];
              return SafeArea(
                child: Stack(children: [
                  flexi_image_slider(
                      indicatorPosition: IndicatorPosition.overImage,
                      context: context,
                      aspectRatio: 1 / 1,
                      boxFit: BoxFit.cover,
                      autoScroll: false,
                      arrayImages: images),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2 + 8,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 247, 237, 252),
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
                                  text: productDetails["name"],
                                  fontWeight: FontWeight.bold,
                                  size: 23),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  myText(
                                      text: productDetails["company"],
                                      size: 17,
                                      color: Colors.grey),
                                  myText(
                                      text: productDetails["in_stock"]
                                          ? "Available in stock"
                                          : "Out of stock",
                                      size: 14,
                                      color: productDetails["in_stock"]
                                          ? Colors.green
                                          : Colors.red)
                                ],
                              ),
                              Row(
                                children: [
                                  StarRating(
                                    starSize: 22,
                                    length: 5,
                                    rating: double.parse(
                                        "${productDetails["rating"]}"),
                                    color: Color.fromARGB(255, 255, 181, 7),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        context.push(
                                            "/homeScreen/productScreen/reviewScreen",
                                            extra: {
                                              "reviews":
                                                  productDetails["reviews"]
                                            });
                                      },
                                      child: myText(
                                          text:
                                              "(See ${reviews.length} Reviews)",
                                          color: Colors.blue,
                                          size: 12))
                                ],
                              ),
                              BlocBuilder<ProductBloc, ProductState>(
                                builder: (context, state) {
                                  return Container(
                                    height: 130,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                InkWell(
                                                    onTap: () {
                                                      selectedSize = "S";
                                                      context
                                                          .read<ProductBloc>()
                                                          .add(ReloadEvent());
                                                    },
                                                    child: sizeIcon(
                                                        "S", selectedSize)),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      selectedSize = "M";
                                                      context
                                                          .read<ProductBloc>()
                                                          .add(ReloadEvent());
                                                    },
                                                    child: sizeIcon(
                                                        "M", selectedSize)),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      selectedSize = "L";
                                                      context
                                                          .read<ProductBloc>()
                                                          .add(ReloadEvent());
                                                    },
                                                    child: sizeIcon(
                                                        "L", selectedSize)),
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
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  selectedColor = Colors.white;
                                                  context
                                                      .read<ProductBloc>()
                                                      .add(ReloadEvent());
                                                },
                                                child: colorIcon(Colors.white,
                                                    selectedColor),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  selectedColor = Colors.black;
                                                  context
                                                      .read<ProductBloc>()
                                                      .add(ReloadEvent());
                                                },
                                                child: colorIcon(Colors.black,
                                                    selectedColor),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  selectedColor = Colors.green;
                                                  context
                                                      .read<ProductBloc>()
                                                      .add(ReloadEvent());
                                                },
                                                child: colorIcon(Colors.green,
                                                    selectedColor),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  selectedColor = Colors.red;
                                                  context
                                                      .read<ProductBloc>()
                                                      .add(ReloadEvent());
                                                },
                                                child: colorIcon(
                                                    Colors.red, selectedColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              myText(
                                  text: "Description",
                                  fontWeight: FontWeight.bold),
                              myText(
                                  text: productDetails["Description"],
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
                      margin: EdgeInsets.only(
                        bottom: 7,
                      ),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          myText(
                              text:
                                  "₹ ${offersPrice == -1 ? productDetails["price"] : offersPrice}",
                              fontWeight: FontWeight.bold,
                              size: 22),
                          InkWell(
                            onTap: () {
                              if (productDetails["in_stock"]) {
                                context.read<ProductBloc>().add(
                                        AddToCartButtonClickedEvent(
                                            context: context,
                                            productDetails: {
                                          "color": getColor(selectedColor),
                                          "company": productDetails["company"],
                                          "count": 1,
                                          "id": productDetails["id"],
                                          "image": productDetails["images"][0],
                                          "name": productDetails["name"],
                                          "price": productDetails["price"],
                                          "size": selectedSize,
                                        }));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("product is out of stock")));
                              }
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 1.8,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
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
                                  myText(
                                      text: "Add to cart", color: Colors.white)
                                ],
                              ),
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
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  String getColor(Color color) {
    switch (color) {
      case Colors.red:
        return "red";
      case Colors.green:
        return "green";
      case Colors.black:
        return "black";
      case Colors.white:
        return "white";
      default:
        return "black";
    }
  }

  Future getProductDetails() async {
    final details = await FirebaseFirestore.instance
        .collection("products")
        .doc(productId)
        .get();
    return details.data();
  }
}
