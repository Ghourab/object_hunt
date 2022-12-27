import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/auth.dart';
import '../screens/editProfile.dart';
import '../screens/instructionsScreen.dart';
import '../screens/leaderBoardScreen.dart';

class StartScreen extends StatelessWidget {
  final User value;
  const StartScreen({Key? key, required this.value}) : super(key: key);

  void instructionScreen(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return InstructionScreen();
        },
      ),
    );
  }

  void editProfileScreen(BuildContext ctx, User value) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return EditProfile(value: value);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
          child: Column(
        children: [
          DrawerHeader(
            child: Text('Menu'),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () => editProfileScreen(context, this.value),
          ),
          ListTile(
            title: Text('Settings'),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout();
              
            },
          ),
        ],
      )),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Welcome to Object Hunt'),
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 150),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/Logo_final.png'))),
        child: Column(children: [
          // Image.asset('assets/object_hunt.png'),

          const SizedBox(
            height: 350,
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
                  child: const Text(
                    'Score',
                    style: TextStyle(fontSize: 19.5, color: Colors.black),
                  ))
            ],
          )
        ]),
      ),
    );
  }
}
