import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/auth.dart';
import '../screens/editProfile.dart';
import '../screens/instructionsScreen.dart';
import '../screens/leaderBoardScreen.dart';
import '../widgets/drawer_wid.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  void instructionScreen(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return InstructionScreen();
        },
      ),
    );
  }

  void editProfileScreen(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return EditProfile();
        },
      ),
    );
  }

  void leaderBoardScreen(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return LeaderBoard();
        },
      ),
    );
  }

  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController,
      drawer: Menu(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => _advancedDrawerController.toggleDrawer(),
          ),
          backgroundColor: Colors.teal[200],
          centerTitle: true,
          title: const Text('Welcome to Object Hunt'),
        ),
        body: Container(
          margin: EdgeInsets.only(bottom: 150),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              Image.asset(
                'assets/images/Logo_final_removebg2.png',
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () => instructionScreen(context),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal[200],
                      ),
                      child: const Text(
                        'Start',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () => leaderBoardScreen(context),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 132, 38, 190),
                      ),
                      child: const Text(
                        'Score',
                        style: TextStyle(
                            fontSize: 19.5,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
