import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/users_provider.dart';
import '../widgets/backGround.dart';
import '../widgets/homeButtons.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (ctx)=> Users_provider(),
      
      child: Scaffold(
        appBar: AppBar(
          title: Text('Object Hunt'),
          backgroundColor: Colors.lightBlue,
        ),
        body: BackGround(HomeButtons(),),
        
      ),
    );
  }
}
