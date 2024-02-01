import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppy/core/common/common_widgets.dart';
import 'package:shoppy/features/home/presentation/widgets/home_screen_widgets.dart';
import 'package:shoppy/features/my_order/presentation/bloc/my_order_bloc.dart';

class MyOrderScreen extends StatelessWidget {
  MyOrderScreen({super.key, required this.myOrderItemDetails});
  Map myOrderItemDetails;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 237, 252),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                myText(
                    text: "Order details",
                    size: 22,
                    fontWeight: FontWeight.bold),
                Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 8,
                            spreadRadius: 3,
                            color: Color.fromARGB(255, 202, 197, 197))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      myText(
                          text:
                              "STREET : ${myOrderItemDetails["address"]["street"]}"),
                      myText(
                          text:
                              "CITY : ${myOrderItemDetails["address"]["city"]}"),
                      myText(
                          text:
                              "DISTRICT : ${myOrderItemDetails["address"]["district"]}"),
                      myText(
                          text:
                              "STATE : ${myOrderItemDetails["address"]["state"]}"),
                      myText(
                          text:
                              "ZIP : ${myOrderItemDetails["address"]["zip"]}"),
                    ],
                  ),
                ),
                myText(text: "Products", size: 22, fontWeight: FontWeight.bold),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: myOrderItemDetails["items"].length,
                      itemBuilder: (context, index) {
                        Map myorderItem = myOrderItemDetails["items"][index];
                        return Container(
                          padding: EdgeInsets.all(10),
                          margin:
                              EdgeInsets.only(right: 10, bottom: 10, top: 10),
                          width: 200,
                          height: 400,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                child: SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: Image.network(
                                    myorderItem["image"],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              myText(text: myorderItem["name"]),
                              myText(text: myorderItem["company"]),
                              myText(text: "Price : ₹ ${myorderItem["price"]}"),
                              Row(
                                children: [
                                  myText(text: "Size : ${myorderItem["size"]}"),
                                  Expanded(child: SizedBox()),
                                  myText(text: "Color :"),
                                  Container(
                                    height: 13,
                                    width: 13,
                                    color: manageColor(myorderItem["color"]),
                                  )
                                ],
                              ),
                              myorderItem["status"] == "deliverd"
                                  ? myButton(() {
                                      addReview(context, myorderItem["id"]);
                                    }, Colors.black, "Add your Review", 26, 200,
                                      10,
                                      textcolor: Colors.white)
                                  : SizedBox()
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> addReview(BuildContext context, String productId) {
    TextEditingController _reviewController = TextEditingController();
    TextEditingController _ratingController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 210,
              child: Column(
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (_reviewController.text.isEmpty) {
                        return "add a review";
                      }
                    },
                    controller: _reviewController,
                    maxLines: 3,
                    minLines: 2,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Type your review here",
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (_ratingController.text.isEmpty) {
                        return "Add your rating";
                      } else if (int.tryParse(_ratingController.text) == null) {
                        return "add a valied rating";
                      } else if (int.parse(_ratingController.text) < 1 ||
                          int.parse(_ratingController.text) > 5) {
                        return "add rating between 1-5";
                      }
                    },
                    keyboardType: TextInputType.number,
                    controller: _ratingController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Type your rating(1-5) here",
                    ),
                  )
                ],
              ),
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    int? rating = int.tryParse(_ratingController.text);
                    if (_ratingController.text.isNotEmpty &&
                        _reviewController.text.isNotEmpty &&
                        rating != null &&
                        (rating >= 1 && rating <= 5)) {
                      context.read<MyOrderBloc>().add(
                          AddREviewButtonClickedEvent(
                              comment: _reviewController.text,
                              productId: productId,
                              rating: int.parse(_ratingController.text)));
                      context.pop();
                    }
                  },
                  child: Text("Submit"))
            ],
          );
        });
  }
}
