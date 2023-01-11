import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../screens/editProfile.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  void editProfileScreen(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return EditProfile();
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
        // ListTile(
        //   title: Text('Settings'),
        //   onTap: () => Settingspage(),
        // ),
        // ListTile(
        //   title: Text('Rating'),
        //   onTap: () => Ratinggame(),
        // ),
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
