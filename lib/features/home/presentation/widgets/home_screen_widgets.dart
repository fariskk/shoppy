import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppy/core/common/common_widgets.dart';
import 'package:shoppy/features/home/presentation/screens/category_screen.dart';
import 'package:shoppy/features/home/presentation/state/bloc/home_bloc.dart';
import 'package:shoppy/features/home/presentation/state/cubit/home_ui_cubit.dart';
import 'package:shoppy/features/payment/presentation/screens/payment_screen.dart';
import 'package:shoppy/features/product_display/presentation/screens/product-screen.dart';
import 'package:star_rating/star_rating.dart';

//home screen navigation bar

BottomNavigationBar myBottomNavigationBar(
    int selectedIndex, BuildContext context) {
  return BottomNavigationBar(
      onTap: (newIndex) {
        context.read<HomeUiCubit>().onNavigationButtonClicked(newIndex);
      },
      selectedItemColor: Colors.grey,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      items: [
        BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/home.png"),
              color: Colors.black,
            ),
            label: "Home"),
        BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/categories.png"),
              color: Colors.black,
            ),
            label: "Category"),
        BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/grocery-store.png"),
              color: Colors.black,
            ),
            label: "Cart"),
        BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/user.png"),
              color: Colors.black,
              size: 22,
            ),
            label: "Account"),
      ]);
}

// home page

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                myText(text: "Shoppy", size: 22, fontWeight: FontWeight.bold),
                Expanded(child: SizedBox()),
                IconButton(
                    onPressed: () {
                      showSearch(context: context, delegate: MySearch());
                    },
                    icon: Icon(Icons.search))
              ],
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("categorys")
                    .doc("offers")
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List offers = snapshot.data["offers"];
                    return CarouselSlider.builder(
                      itemCount: offers.length,
                      itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) {
                        Map offerItem = offers[itemIndex];
                        return GestureDetector(
                          onTap: () {
                            context.go("/homeScreen/productScreen", extra: {
                              "product_id": offerItem["id"],
                              "offer_price": offerItem["offer"]
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(offerItem["image"]),
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                myText(
                                    text:
                                        "₹ ${calcOffer(offerItem["price"], offerItem["offer"])} % off",
                                    size: 30,
                                    color: Color.fromARGB(255, 23, 218, 42),
                                    fontWeight: FontWeight.bold),
                                myText(
                                    text: offerItem["name"],
                                    size: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ],
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  myText(text: "New Arrivals", fontWeight: FontWeight.bold),
                  Container(
                    height: 205,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("categorys")
                          .doc("new_arrivals")
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          List newArrivals = snapshot.data["new_arrivals"];
                          return ListView.builder(
                              itemCount: newArrivals.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                Map newArrivalItem = newArrivals[index];
                                return GestureDetector(
                                  onTap: () {
                                    context.go("/homeScreen/productScreen",
                                        extra: {
                                          "product_id": newArrivalItem["id"],
                                          "offer_price": -1
                                        });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 150,
                                          width: 150,
                                          margin: EdgeInsets.only(
                                            right: 10,
                                            top: 10,
                                          ),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      newArrivalItem["image"])),
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15))),
                                        ),
                                        myText(
                                            text: newArrivalItem["name"],
                                            fontWeight: FontWeight.bold,
                                            size: 15),
                                        myText(
                                            text: newArrivalItem["price"]
                                                .toString(),
                                            fontWeight: FontWeight.bold,
                                            size: 16),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                  myText(text: "Popular", fontWeight: FontWeight.bold),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                    child: StreamBuilder<Object>(
                        stream: FirebaseFirestore.instance
                            .collection("categorys")
                            .doc("popular")
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            List popular = snapshot.data["popular"];
                            return ListView.builder(
                                itemCount: popular.length,
                                itemBuilder: (context, index) {
                                  Map popularItem = popular[index];
                                  return GestureDetector(
                                    onTap: () {
                                      context.go("/homeScreen/productScreen",
                                          extra: {
                                            "product_id": popularItem["id"],
                                            "offer_price": -1
                                          });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: const Color.fromARGB(
                                                    255, 223, 223, 223),
                                                blurRadius: 5,
                                                offset: Offset(0, 2))
                                          ]),
                                      child: ListTile(
                                        leading: Image.network(
                                          popularItem["image"],
                                          fit: BoxFit.cover,
                                        ),
                                        title: Text(popularItem["name"]),
                                        subtitle: StarRating(
                                          rating: double.parse(
                                              "${popularItem["rating"]}"),
                                          length: 5,
                                          color:
                                              Color.fromARGB(255, 255, 153, 0),
                                        ),
                                        trailing: myText(
                                            text: "₹ ${popularItem["price"]}",
                                            fontWeight: FontWeight.bold,
                                            size: 16),
                                      ),
                                    ),
                                  );
                                });
                          }
                          return Center(child: CircularProgressIndicator());
                        }),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

int calcOffer(num price, num offer) {
  num offerPercentage = (price - offer) / price * 100;

  return offerPercentage.ceil();
}

class MySearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: getAllData(),
        builder: (context, snapshot) {
          List resultList = [];
          if (snapshot.hasData) {
            for (var i in snapshot.data) {
              if (i["name"]
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  i["type"].toString().contains(query)) {
                resultList.add(i);
              }
            }
            return searchResultTile(resultList);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: getAllData(),
        builder: (context, snapshot) {
          List resultList = [];
          if (snapshot.hasData) {
            for (var i in snapshot.data) {
              if (i["name"]
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  i["type"].toString().contains(query)) {
                resultList.add(i);
              }
            }
            return searchResultTile(resultList);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  ListView searchResultTile(List<dynamic> resultList) {
    return ListView.builder(
        itemCount: resultList.length,
        itemBuilder: (context, index) {
          Map resultItem = resultList[index];
          return ListTile(
            onTap: () {
              context.go("/homeScreen/productScreen",
                  extra: {"product_id": resultItem["id"], "offer_price": -1});
            },
            leading: Container(
              width: 60,
              height: 60,
              child: Image.network(resultItem["images"][0]),
            ),
            title: myText(text: resultItem["name"]),
            subtitle: myText(
                text: "in catogory : ${resultItem["type"]}",
                color: Colors.green,
                size: 12),
          );
        });
  }

  Future getAllData() async {
    final data = await FirebaseFirestore.instance.collection("products").get();
    return data.docs.map((e) => e.data()).toList();
  }
}

//categories page

class CategoriePage extends StatelessWidget {
  const CategoriePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: myText(
                text: " categories", size: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          categoriTile("Clothes", "clothes", "assets/images/clotes_image.jpg",
              Alignment.centerRight, context),
          categoriTile("Bags", "bags", "assets/images/bags_image.webp",
              Alignment.centerLeft, context),
          categoriTile("Shoes", "shoes", "assets/images/shoes_image.png",
              Alignment.centerRight, context),
          categoriTile(
              "Electronics",
              "electronics",
              "assets/images/electronics_image.jpg",
              Alignment.centerLeft,
              context),
          categoriTile("Jewelry", "jewelry", "assets/images/jewlery_image.jpg",
              Alignment.centerRight, context),
        ],
      ),
    );
  }
}

Widget categoriTile(String title, String searchId, String image,
    Alignment alignment, BuildContext context) {
  return GestureDetector(
    onTap: () {
      context.go("/homeScreen/categoryScreen",
          extra: {"title": title, "search_id": searchId});
    },
    child: Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 7),
      height: 120,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      width: double.infinity,
      child: Align(
        alignment: alignment,
        child: myText(
            text: title,
            size: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
    ),
  );
}

//cart page

class CartPage extends StatelessWidget {
  CartPage({super.key});
  double total = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List myCart = snapshot.data["my_cart"];
              Map myAddress = snapshot.data["address"];
              total = 0;
              myCart.forEach((value) {
                total += value["price"] * value["count"];
              });

              return Column(
                children: [
                  Row(
                    children: [
                      myText(
                          text: " My Cart",
                          size: 22,
                          fontWeight: FontWeight.bold),
                      Expanded(child: SizedBox()),
                      Container(
                        height: 50,
                        width: 50,
                        child: Stack(
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: ImageIcon(
                                  AssetImage(
                                    "assets/icons/grocery-store.png",
                                  ),
                                  size: 22,
                                )),
                            Align(
                                alignment: Alignment.topCenter,
                                child: Text("${myCart.length}"))
                          ],
                        ),
                      )
                    ],
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: myCart.length,
                          itemBuilder: (context, index) {
                            Map mycartItem = myCart[index];
                            return cartItem(mycartItem, index, myCart, context);
                          })),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      myText(text: "Total(${myCart.length} item):"),
                      myText(text: "₹ $total"),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (myCart.length == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("your cart is empty")));
                      } else if (myAddress.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(
                                    "Your Shipping Address hasn't been Updated,\n\nUpdate your Address to Continue"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        context.pop();
                                      },
                                      child: Text("Cancel")),
                                  TextButton(
                                      onPressed: () {
                                        context.pop();
                                        context.go("/homeScreen/addressScreen");
                                      },
                                      child: Text("Update"))
                                ],
                              );
                            });
                      } else {
                        context.read<HomeBloc>().add(
                            ProceedToPaymentButtonClickedEvent(
                                amount: total,
                                context: context,
                                myCart: myCart,
                                shippingAddres: myAddress));
                      }
                    },
                    child: Container(
                      height: 60,
                      padding: EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width - 30,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          myText(
                              text: "Proceed to Checkout", color: Colors.white),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

Widget cartItem(Map mycartItem, int index, List myCart, BuildContext context) {
  return GestureDetector(
    onTap: () {
      context.go("/homeScreen/productScreen", extra: {
        "product_id": mycartItem["id"],
        "offer_price": mycartItem["price"]
      });
    },
    child: Container(
      margin: EdgeInsets.only(bottom: 20),
      height: 180,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    image: DecorationImage(
                        image: NetworkImage(
                          mycartItem["image"],
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(
                                    "Remove ${mycartItem["name"]} from cart ?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        context.pop();
                                      },
                                      child: Text("Cancel")),
                                  TextButton(
                                      onPressed: () {
                                        context.read<HomeBloc>().add(
                                            DeleteCartItemButtonClickedEvent(
                                                index: index, myCart: myCart));
                                        context.pop();
                                      },
                                      child: Text("OK"))
                                ],
                              );
                            });
                      },
                      icon: ImageIcon(
                        AssetImage('assets/icons/delete.png'),
                        size: 18,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        myText(text: "size : ${mycartItem["size"]}"),
                        SizedBox(
                          width: 10,
                        ),
                        myText(text: "color:"),
                        SizedBox(
                          width: 3,
                        ),
                        Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                              color: manageColor(
                                mycartItem["color"],
                              ),
                              border:
                                  Border.all(color: Colors.grey, width: 1.5)),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    height: 45,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 249, 239, 239),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              if (mycartItem["count"] > 1) {
                                context.read<HomeBloc>().add(
                                    QuantitydecreeseButtonClickedEvent(
                                        index: index,
                                        myCart: myCart,
                                        currentCount: mycartItem["count"]));
                              }
                            },
                            icon: Icon(Icons.remove)),
                        myText(text: "${mycartItem["count"]}"),
                        IconButton(
                            onPressed: () {
                              if (mycartItem["count"] < 10) {
                                context.read<HomeBloc>().add(
                                    QuantityIncreeseButtonClickedEvent(
                                        index: index,
                                        myCart: myCart,
                                        currentCount: mycartItem["count"]));
                              }
                            },
                            icon: Icon(Icons.add))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              myText(
                text: mycartItem["name"],
              ),
              Expanded(child: SizedBox()),
              myText(text: "\$${mycartItem["price"]}"),
              SizedBox(
                width: 5,
              )
            ],
          )
        ],
      ),
    ),
  );
}

Color manageColor(String color) {
  switch (color) {
    case "red":
      return Colors.red;
    case "green":
      return Colors.green;
    case "black":
      return Colors.black;
    case "white":
      return Colors.white;
  }
  return Colors.white;
}

//profile page

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 180, 179, 179),
                        blurRadius: 8,
                        offset: Offset(0, 3))
                  ]),
              child: ListTile(
                  title: myText(
                    text:
                        "Name : ${FirebaseAuth.instance.currentUser!.email!.split("@").first}",
                    color: Colors.grey,
                  ),
                  subtitle: myText(
                    text:
                        "Email  : ${FirebaseAuth.instance.currentUser!.email}",
                    color: Colors.grey,
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                      color: const Color.fromARGB(255, 201, 200, 200),
                      width: 2)),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  settingsTile(
                      "My Orders",
                      ImageIcon(AssetImage("assets/icons/shopping-bag.png")),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("users")
                                .doc(FirebaseAuth.instance.currentUser!.email)
                                .snapshots(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                List myOrders = snapshot.data["my_orders"];
                                if (myOrders.length == 0) {
                                  return Center(
                                    child: myText(text: "No Items"),
                                  );
                                }

                                return ListView.builder(
                                    itemCount: myOrders.length,
                                    itemBuilder: (context, index) {
                                      List items = myOrders[index]["items"];
                                      String productsText =
                                          items.map((e) => e["name"]).join(",");
                                      return Card(
                                        child: ListTile(
                                          title: myText(
                                              text: myOrders[index]["name"],
                                              size: 14,
                                              fontWeight: FontWeight.bold),
                                          subtitle: Text(productsText),
                                          trailing: TextButton(
                                            child: Text("View Details"),
                                            onPressed: () {
                                              context.go(
                                                  "/homeScreen/myorderScreen",
                                                  extra: myOrders[index]);
                                            },
                                          ),
                                        ),
                                      );
                                    });
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }),
                      )),
                  settingsTile(
                      "my Favourites",
                      ImageIcon(AssetImage("assets/icons/heart.png")),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("users")
                                .doc(FirebaseAuth.instance.currentUser!.email)
                                .snapshots(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                List myFavorites =
                                    snapshot.data["my_favourites"];
                                if (myFavorites.length == 0) {
                                  return Center(
                                    child: myText(text: "No Items"),
                                  );
                                }
                                return productTile(myFavorites);
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }),
                      )),
                  settingsTile(
                      "Shipping Address",
                      ImageIcon(AssetImage("assets/icons/delivery-truck.png")),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data["address"].isEmpty) {
                                return TextButton(
                                    onPressed: () {
                                      context.go("/homeScreen/addressScreen");
                                    },
                                    child: Text("Add your address"));
                              } else {
                                Map myAddress = snapshot.data["address"];
                                return Container(
                                  padding: EdgeInsets.all(15),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                          text:
                                              "Street : ${myAddress["street"]}"),
                                      myText(
                                          text: "City : ${myAddress["city"]}"),
                                      myText(
                                          text:
                                              "District : ${myAddress["district"]}"),
                                      myText(
                                          text:
                                              "State : ${myAddress["state"]}"),
                                      myText(text: "Zip : ${myAddress["zip"]}"),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                          ),
                                          onPressed: () {
                                            context.go(
                                                "/homeScreen/addressScreen");
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }
                            }
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            );
                          })),
                  settingsTile(
                      "Settings",
                      ImageIcon(AssetImage("assets/icons/heart.png")),
                      Column(
                        children: [
                          ListTile(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Logout ?"),
                                      content:
                                          Text("Are sure you want to logout"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              context.pop();
                                            },
                                            child: Text("Cancel")),
                                        TextButton(
                                            onPressed: () {
                                              FirebaseAuth.instance.signOut();
                                              context.go("/");
                                            },
                                            child: Text("Ok"))
                                      ],
                                    );
                                  });
                            },
                            leading: ImageIcon(
                                AssetImage("assets/icons/logout.png")),
                            title: myText(text: "Logout"),
                          ),
                        ],
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  ListView productTile(List products) {
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          Map myOrdersItem = products[index];
          return Card(
            child: ListTile(
              onTap: () {
                context.go("/homeScreen/productScreen", extra: {
                  "product_id": myOrdersItem["id"],
                  "offer_price": -1
                });
              },
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Remove from favorites?"),
                        content: Text("Are you sure you want to remove ?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: Text("Cancel")),
                          TextButton(
                              onPressed: () {
                                removeFavoriteItem(myOrdersItem["id"], context);
                                context.pop();
                              },
                              child: Text("ok"))
                        ],
                      );
                    });
              },
              subtitle: myText(
                  text: myOrdersItem["name"],
                  size: 16,
                  fontWeight: FontWeight.bold),
              leading: Container(
                height: 60,
                width: 60,
                child: Image.network(
                  myOrdersItem["image"],
                  fit: BoxFit.cover,
                ),
              ),
              trailing: myText(text: "₹ ${myOrdersItem["price"]}"),
            ),
          );
        });
  }
}

Widget settingsTile(String title, ImageIcon icon, Widget widget) {
  return ExpansionTile(
    iconColor: Colors.black,
    leading: icon,
    title: myText(text: title),
    children: [widget],
  );
}
