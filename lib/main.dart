import 'package:firebase_core/firebase_core.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;

import '/providers/auth.dart';
import '/providers/user_provider.dart';
import '../screens/splash_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/start_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
  bool musicPlaying = false;
  FlameAudio.bgm.initialize();
  if (!musicPlaying) {
    FlameAudio.bgm.play('music.mp3');
    musicPlaying = true;
  }
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          theme: ref.watch(themeProvider).when(
                data: (data) => (data == "light")
                    ? ThemeData(
                        fontFamily: 'QuickSand',
                        textTheme: ThemeData.light().textTheme.copyWith(
                              headline6: TextStyle(
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                        appBarTheme: AppBarTheme(
                          toolbarTextStyle: ThemeData.light().textTheme.copyWith(
                                headline6: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ).bodyText2, titleTextStyle: ThemeData.light().textTheme.copyWith(
                                headline6: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ).headline6,
                        ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: Colors.black),
                      )
                    : ThemeData(
                        fontFamily: 'QuickSand',
                        textTheme: ThemeData.light().textTheme.copyWith(
                              headline6: TextStyle(
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                        appBarTheme: AppBarTheme(
                          toolbarTextStyle: ThemeData.light().textTheme.copyWith(
                                headline6: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ).bodyText2, titleTextStyle: ThemeData.light().textTheme.copyWith(
                                headline6: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ).headline6,
                        ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red).copyWith(secondary: Color.fromARGB(255, 254, 8, 8)),
                      ),
                error: (err, st) => ThemeData(
                  fontFamily: 'QuickSand',
                  textTheme: ThemeData.light().textTheme.copyWith(
                        headline6: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                  appBarTheme: AppBarTheme(
                    toolbarTextStyle: ThemeData.light().textTheme.copyWith(
                          headline6: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ).bodyText2, titleTextStyle: ThemeData.light().textTheme.copyWith(
                          headline6: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ).headline6,
                  ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: Colors.black),
                ),
                loading: () => ThemeData(
                  fontFamily: 'QuickSand',
                  textTheme: ThemeData.light().textTheme.copyWith(
                        headline6: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                  appBarTheme: AppBarTheme(
                    toolbarTextStyle: ThemeData.light().textTheme.copyWith(
                          headline6: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ).bodyText2, titleTextStyle: ThemeData.light().textTheme.copyWith(
                          headline6: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ).headline6,
                  ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: Colors.black),
                ),
              ),

          //home: ArGameScreen(),

          home: auth.isAuth
              ? StartScreen()
              : FutureBuilder(
                  future: auth.autoLogin(ref),
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
