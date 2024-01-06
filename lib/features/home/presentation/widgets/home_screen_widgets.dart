import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/core/common/common_widgets.dart';
import 'package:shoppy/features/home/presentation/state/cubit/home_ui_cubit.dart';
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
                IconButton(onPressed: () {}, icon: Icon(Icons.search))
              ],
            ),
            CarouselSlider.builder(
              itemCount: 15,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.green,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/image2.jpg"))),
                  child: Column(
                    children: [],
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  myText(text: "New Arrivals", fontWeight: FontWeight.bold),
                  Container(
                    height: 205,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Column(
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
                                        image: AssetImage(
                                            "assets/images/image2.jpg")),
                                    color: Colors.amber,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                              ),
                              myText(
                                  text: "The marc Jacobs",
                                  fontWeight: FontWeight.bold,
                                  size: 15),
                              myText(
                                  text: "\$158.5",
                                  fontWeight: FontWeight.bold,
                                  size: 16),
                            ],
                          );
                        }),
                  ),
                  myText(text: "Popular", fontWeight: FontWeight.bold),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                    child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color.fromARGB(
                                          255, 223, 223, 223),
                                      blurRadius: 5,
                                      offset: Offset(0, 2))
                                ]),
                            child: ListTile(
                              leading: Image.asset(
                                "assets/images/image2.jpg",
                                fit: BoxFit.cover,
                              ),
                              title: Text("Gia Bogini"),
                              subtitle: StarRating(
                                rating: 2,
                                length: 5,
                                color: Color.fromARGB(255, 255, 153, 0),
                              ),
                              trailing: myText(
                                  text: "\$45.5",
                                  fontWeight: FontWeight.bold,
                                  size: 16),
                            ),
                          );
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
          categoriTile(
              "New arrivals", "assets/images/image2.jpg", Alignment.centerLeft),
          categoriTile(
              "Clothes", "assets/images/image2.jpg", Alignment.centerRight),
          categoriTile(
              "Bags", "assets/images/image2.jpg", Alignment.centerLeft),
          categoriTile(
              "Shoes", "assets/images/image2.jpg", Alignment.centerRight),
          categoriTile(
              "Electronics", "assets/images/image2.jpg", Alignment.centerLeft),
          categoriTile(
              "Jewelry", "assets/images/image2.jpg", Alignment.centerRight),
        ],
      ),
    );
  }
}

Widget categoriTile(String title, String image, Alignment alignment) {
  return Container(
    padding: EdgeInsets.all(20),
    margin: EdgeInsets.symmetric(vertical: 7),
    height: 120,
    decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        borderRadius: BorderRadius.all(Radius.circular(20))),
    width: double.infinity,
    child: Align(
      alignment: alignment,
      child: myText(text: title, size: 22, fontWeight: FontWeight.bold),
    ),
  );
}

//cart page

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            children: [
              myText(text: " My Cart", size: 22, fontWeight: FontWeight.bold),
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
                    Align(alignment: Alignment.topCenter, child: Text("5"))
                  ],
                ),
              )
            ],
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return cartItem(
                        "assets/images/image2.jpg", "rollar Rabbit", 158.5);
                  })),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              myText(text: "Total(3 item):"),
              myText(text: "\$500.5"),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {},
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
                  myText(text: "Proceed to Checkout", color: Colors.white),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget cartItem(String image, String brand, double price) {
  int quantity = 1;
  return Container(
    height: 180,
    width: double.infinity,
    child: Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.cover),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {},
                  icon: ImageIcon(
                    AssetImage('assets/icons/delete.png'),
                    size: 18,
                  )),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.all(10),
                height: 45,
                width: 105,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.remove)),
                    myText(text: "$quantity"),
                    IconButton(onPressed: () {}, icon: Icon(Icons.add))
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            myText(text: brand),
            Expanded(child: SizedBox()),
            myText(text: "\$$price"),
            SizedBox(
              width: 5,
            )
          ],
        )
      ],
    ),
  );
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
                  leading: Container(
                    height: 60,
                    width: 60,
                    child: Image.asset(
                      "assets/images/background_image2.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text("Gia Bogini"),
                  subtitle: myText(
                      text: "faris@gmail.com", color: Colors.grey, size: 16)),
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
                      "Personal Details",
                      ImageIcon(AssetImage("assets/icons/heart.png")),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 205,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            personalDetailsItem(
                                context, "Name", TextEditingController()),
                            personalDetailsItem(
                                context, "Age", TextEditingController()),
                            personalDetailsItem(
                                context, "Email", TextEditingController()),
                          ],
                        ),
                      )),
                  settingsTile(
                      "My Orders",
                      ImageIcon(AssetImage("assets/icons/heart.png")),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        child: productTile([]),
                      )),
                  settingsTile(
                      "my Favourites",
                      ImageIcon(AssetImage("assets/icons/heart.png")),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        child: productTile([]),
                      )),
                  settingsTile(
                      "Shipping Address",
                      ImageIcon(AssetImage("assets/icons/heart.png")),
                      Container(
                        // height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color.fromARGB(255, 240, 240, 239),
                            border: Border.all(width: 2, color: Colors.grey)),
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          minLines: 3,
                          maxLines: 5,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      )),
                  settingsTile(
                      "Settings",
                      ImageIcon(AssetImage("assets/icons/heart.png")),
                      Column()),
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
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: myText(
                  text: "Head phone", size: 16, fontWeight: FontWeight.bold),
              leading: Container(
                height: 60,
                width: 60,
                child: Image.asset(
                  "assets/images/background_image2.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              trailing: myText(text: "\$545"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  myText(text: "Quantity: 1", size: 10),
                  myText(text: "Size: 1", size: 10),
                  Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        myText(text: "Color:", size: 10),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 10,
                          width: 10,
                          color: Colors.blue,
                        )
                      ]),
                ],
              ),
            ),
          );
        });
  }

  Row personalDetailsItem(BuildContext context, String title,
      TextEditingController _textController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        myText(text: "$title :"),
        Container(
            padding: EdgeInsets.only(bottom: 20),
            width: MediaQuery.of(context).size.width / 2,
            child: TextField(
              controller: _textController,
            ))
      ],
    );
  }
}

Widget settingsTile(String title, ImageIcon icon, Widget widget) {
  return ExpansionTile(
    leading: icon,
    title: myText(text: title),
    children: [widget],
  );
}
