import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ReadyScreen extends StatelessWidget {
  const ReadyScreen({ Key? key }) : super(key: key);
  void popScreen(BuildContext ctx){
  Navigator.of(ctx).pop(ctx);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Object Hunt'),
        backgroundColor: Colors.red,
      ),
      body: Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height,color: Colors.black,
        child: Center(
          child: Container(width: MediaQuery.of(context).size.width/1.8, height: MediaQuery.of(context).size.height/2,
            child: Card(color: Colors.red,
              child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DefaultTextStyle(
    style: const TextStyle(
      fontSize: 30,
      fontFamily: 'Canterbury',
    ),
    child: AnimatedTextKit(
      animatedTexts: [
        ScaleAnimatedText('Seeker'),
       
        ScaleAnimatedText('Ready ?'),
      ],)),
                  Center(child: Image.asset('assets/images/seeker.gif')),
                  ElevatedButton(onPressed:()=>popScreen(context),child: Text('Ready'),style:ElevatedButton.styleFrom(backgroundColor: Colors.black)),
                ],
              ),
            ),
          ),
        ),
      ),
      
    );
  }
}