import 'package:flutter/material.dart';
import 'package:shoppy/core/common/common_widgets.dart';
import 'package:star_rating/star_rating.dart';

class ReviewScreen extends StatelessWidget {
  ReviewScreen({super.key, required this.reviews});
  List reviews;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: myText(text: "Reviews"),
      ),
      body: SafeArea(
          child: ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                Map reviewItem = reviews[index];
                return Card(
                  child: ListTile(
                    title: myText(text: reviewItem["name"], size: 17),
                    subtitle: myText(
                      text: reviewItem["comment"],
                      size: 20,
                    ),
                    trailing: Container(
                      height: 50,
                      width: 100,
                      child: StarRating(
                        color: Color.fromARGB(255, 232, 214, 14),
                        rating: double.parse("${reviewItem["rating"]}"),
                        length: 5,
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}
