import 'package:flutter/material.dart';

import 'screens/loadingScreen.dart';

// import './screens/loadingScreen.dart';
// import './screens/editProfile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'object hunt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.black,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              
        ),
      ),

      //home: ArGameScreen(),

      home: LoadingScreen(),
      // home: EditProfile(),
    );
  }
}
