// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// // import './screens/loadingScreen.dart';
// // import './screens/editProfile.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:provider/provider.dart';

// import '/providers/auth.dart';
// import '../screens/splash_screen.dart';
// import '../screens/startScreen.dart';
// import 'screens/auth_screen.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//   await Firebase.initializeApp();
//   runApp(ProviderScope(child: MyApp()));
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider.value(
//           value: Auth(),
//         ),
//       ],
//       child: Consumer<Auth>(
//         builder: (ctx, auth, _) => MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'object hunt',
//           theme: ThemeData(
//             primarySwatch: Colors.blue,
//             accentColor: Colors.black,
//             fontFamily: 'QuickSand',
//             textTheme: ThemeData.light().textTheme.copyWith(
//                   headline6: TextStyle(
//                     fontFamily: 'OpenSans',
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//             appBarTheme: AppBarTheme(
//               textTheme: ThemeData.light().textTheme.copyWith(
//                     headline6: TextStyle(
//                       fontFamily: 'OpenSans',
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20,
//                     ),
//                   ),
//             ),
//           ),

//           //home: ArGameScreen(),

//           home: auth.isAuth
//               ? StartScreen()
//               : FutureBuilder(
//                   future: auth.autoLogin(),
//                   builder: (ctx, authResultSnapshot) =>
//                       authResultSnapshot.connectionState ==
//                               ConnectionState.waiting
//                           ? SplashScreen()
//                           : AuthScreen(),
//                 ),
//           // home: EditProfile(),
//         ),
//       ),
//     );
//   }
// }
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;

import '/providers/auth.dart';
import '../screens/splash_screen.dart';
import '../screens/startScreen.dart';
import 'screens/auth_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return provider.MultiProvider(
      providers: [
        provider.ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
      child: provider.Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
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

          home: auth.isAuth
              ? StartScreen()
              : FutureBuilder(
                  future: auth.autoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          // home: EditProfile(),
        ),
      ),
    );
  }
}