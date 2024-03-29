import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'ar_game_screen.dart';

class HiderScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splashIconSize: 300,
        backgroundColor: Colors.black,
        pageTransitionType: PageTransitionType.bottomToTop,
        splashTransition: SplashTransition.rotationTransition,
        splash:   Container(child: Center(child: Text('Hider Turn',style:TextStyle(color: Colors.blue,fontSize: 46),)) ,color: Colors.black ,width:double.infinity),
        
        nextScreen:  ArGameScreen(),

// we can use
        duration: 1000,
//5000= 5 Second

//control the duration of the image , we can use
        animationDuration: const Duration(seconds: 2));
//small number : the duration will be speed
//large number : the duratiion will be slow);
  }
}

