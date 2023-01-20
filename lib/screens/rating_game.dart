import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Ratinggame extends StatefulWidget {
  const Ratinggame({Key? key}) : super(key: key);

  @override
  State<Ratinggame> createState() => _RatinggameState();
}

class _RatinggameState extends State<Ratinggame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Rating')),
        body: Center(
            child: Column(
          children: [
            //rating face bar
            const Text('Game Rating',
                style: TextStyle(
                    fontWeight: FontWeight.bold, height: 5, fontSize: 10)),
            RatingBar(
              initialRating: 3,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              ratingWidget: RatingWidget(
                full: Image.asset('assets/images/heart.png'),
                half: Image.asset('assets/images/heart_half.png'),
                empty: Image.asset('assets/images/heart_border.png'),
              ),
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              onRatingUpdate: (rating) {
                print(rating);
              },
            )
          ],
        )));
  }
}
