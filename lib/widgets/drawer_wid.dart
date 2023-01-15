import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../screens/Volume.dart';
import '../screens/editProfile.dart';
import '../screens/ratinggame.dart';
import '../screens/settings_page.dart';


class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  void editProfileScreen(BuildContext ctx) async{
    await Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return EditProfile();
        },
      ),
    );
  }

  void ratingsScreen(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Ratinggame();
        },
      ),
    );
  }

  void settingsGame(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return SettingsPage();
        },
      ),
    );
  }

  void gameVolume(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Volume();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        SizedBox(
          height: 100,
          child: Expanded(
            child: Container(
                color: Colors.teal[200], child: Center(child: Text('Menu'))),
          ),
        ),
        ListTile(
          title: Text('Profile'),
          onTap: () => editProfileScreen(context),
        ),
        ListTile(
          title: Text('Settings'),
          onTap: () => settingsGame(context),
        ),
        ListTile(
          title: Text('Volume'),
          onTap: () => gameVolume(context),
        ),
        ListTile(
          title: Text('Rating'),
          onTap: () => ratingsScreen(context),
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Logout'),
          onTap: () {
            Provider.of<Auth>(context, listen: false).logout();
          },
        ),
      ],
    ));
  }
}
