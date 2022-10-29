import 'package:flutter/material.dart';
import '../screens/editProfile.dart';

import '../screens/hiderScreen.dart';

class StartScreen extends StatelessWidget {

    void hiderScreen(BuildContext ctx){
  Navigator.of(ctx).push(MaterialPageRoute(builder: (_){
    return HiderScreen();
  },),);
}

 void editProfileScreen(BuildContext ctx){
  Navigator.of(ctx).push(MaterialPageRoute(builder: (_){
    return EditProfile();
  },),);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            child: Text('Menu'),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            title: Text('Profile'),onTap: () => editProfileScreen(context),
          ),
          ListTile(
            title: Text('Settings'),
          ),
        ],
      )),
      appBar: AppBar(
        title: const Text('Welcome to Object Hunt'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/object_hunt.png'), fit: BoxFit.fill)),
        child: ListView(padding: const EdgeInsets.all(10), children: [
          // Image.asset('assets/object_hunt.png'),

          const SizedBox(
            height: 500,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: ()=>hiderScreen(context), child: const Text('Start')),
              ElevatedButton(onPressed: () {}, child: const Text('Score'))
            ],
          )
        ]),
      ),
    );
  }
}
