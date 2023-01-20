import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

import 'hider_screen.dart';

class InstructionScreen extends StatefulWidget {
  const InstructionScreen({Key? key}) : super(key: key);

  @override
  State<InstructionScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<InstructionScreen> {
  List<Slide> slides = [];
  void hiderScreen(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return HiderScreen();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        widthImage: 300.0,
        heightImage: 300.0,
        title: "Getting Started",
        description: "Use this app in an open space for the best experience.",
        pathImage: "assets/images/alert_2.png",
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
    );
    slides.add(
      new Slide(
        widthImage: 300.0,
        heightImage: 300.0,
        title: "Getting Started",
        description: "Be aware of your surroundings at all times.",
        pathImage: "assets/images/alert_1.png",
        backgroundColor:  Color.fromARGB(255, 0, 0, 0),
      ),
    );
    slides.add(
      new Slide(
        widthImage: 300.0,
        heightImage: 300.0,
        title: "Getting Started",
        description:
            "Enable Camera and Disk access to start seeing products in augmented reality. You may accept when asked or go to the settings panel of your device",
        pathImage: "assets/images/phone.png",
        backgroundColor:  Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }

  void onDonePress() {
    hiderScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
    );
  }
}
