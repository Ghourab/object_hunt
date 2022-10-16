import 'package:flutter/material.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Object Hunt'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Start'),
          style: ElevatedButton.styleFrom(
              elevation: 10,
            
          ),
        ),
      ),
    );
  }
}
