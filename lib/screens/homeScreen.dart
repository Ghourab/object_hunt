import 'package:flutter/material.dart';

import '../widgets/backGround.dart';
import '../widgets/homeButtons.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Object Hunt'),
        backgroundColor: Colors.lightBlue,
      ),
      body: BackGround(HomeButtons(),),
      
    );
  }
}
