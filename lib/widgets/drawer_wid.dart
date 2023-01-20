import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../screens/api_screen.dart';
import '../screens/edit_profile.dart';
import '../screens/rating_game.dart';
import '../screens/settings_page.dart';
import '../screens/volume.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  void editProfileScreen(BuildContext ctx) async {
    await Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return EditProfile();
        },
      ),
    );
  }

  void apiScreen(BuildContext ctx) async {
    await Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return APi();
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
          
            child: Container(
                color: Colors.red, child: Center(child: Text('Menu'))),
      
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
          title: Text('Giveaways'),
          onTap: () => apiScreen(context),
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
