import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        padding: const EdgeInsets.all(0),
        children: const [
          DrawerHeader(
            child: Text('Menu'),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            title: Text('Profile'),
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
                image: AssetImage('assets/object_hunt.png'), fit: BoxFit.fill)),
        child: ListView(padding: const EdgeInsets.all(10), children: [
          // Image.asset('assets/object_hunt.png'),

          const SizedBox(
            height: 500,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text('Start')),
              ElevatedButton(onPressed: () {}, child: const Text('Score'))
            ],
          )
        ]),
      ),
    );
  }
}
