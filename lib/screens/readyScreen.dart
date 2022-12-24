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
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(child: ElevatedButton(onPressed:()=>popScreen(context),child: Text('Ready'))),
      
    );
  }
}