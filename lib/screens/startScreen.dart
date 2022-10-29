import 'package:flutter/material.dart';

import '../models/users.dart';
import '../screens/editProfile.dart';
import '../screens/hiderScreen.dart';

class StartScreen extends StatelessWidget {
  final User value;
 const StartScreen({Key? key,required this.value}) : super(key: key);
    void hiderScreen(BuildContext ctx){
  Navigator.of(ctx).push(MaterialPageRoute(builder: (_){
    return HiderScreen();
  },),);
}

 void editProfileScreen(BuildContext ctx,User value){
  Navigator.of(ctx).push(MaterialPageRoute(builder: (_){
    return EditProfile(value:value);
  },),);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
          child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            child: Text('Menu'),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            title: Text('Profile'),onTap: () => editProfileScreen(context,this.value),
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
        margin: EdgeInsets.only(bottom: 200),
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
            image: AssetImage('assets/images/Logo_final.png'))),
            child: ListView(padding: const EdgeInsets.all(10), children: [
          // Image.asset('assets/object_hunt.png'),

          const SizedBox(
            height: 400,
          ),
          Column(
           
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: ()=>hiderScreen(context),
              
               style: ElevatedButton.styleFrom(primary : Colors.teal[200],),
               child: const Text('Start', 
               style: TextStyle(fontSize: 20, color: Colors.black),)),

              ElevatedButton(onPressed: () {}, child: const Text('Score',style: TextStyle(fontSize: 19.5, color: Colors.black),))
            ],
          )
        ]),
      ),
    );
  }
}
