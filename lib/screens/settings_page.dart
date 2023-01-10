 import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class Settingspage extends StatefulWidget {
  Settingspage({Key? key}) : super(key: key);
  @override
  _SettingspageState createState() => _SettingspageState();
}

class _SettingspageState extends State<Settingspage> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            titlePadding: EdgeInsets.all(20),
            title: 'General',
            tiles: [
              SettingsTile(
                title: 'Language',
                subtitle: 'English',
                leading: Icon(Icons.language),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: 'Use System Theme',
                leading: Icon(Icons.phone_android),
                switchValue: isSwitched,
                onToggle: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
            ],
          ),
          SettingsSection(
            titlePadding: EdgeInsets.all(20),
            title: 'Privacy',
            tiles: [
              SettingsTile(
                title: 'Security',
                subtitle: 'Fingerprint',
                leading: Icon(Icons.lock),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: 'Use fingerprint',
                leading: Icon(Icons.fingerprint),
                switchValue: true,
                onToggle: (value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Object hunt',
//       theme: ThemeData(
//         brightness: Brightness.light,
//       ),
//       darkTheme: ThemeData(
//         brightness: Brightness.dark,
//       ),
//       home: MyHomePage(title: 'Object hunt'),
//     );
//     home:
//     MyHomePage(title: 'Object hunt');
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   bool isSwitched = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: SettingsList(
//         sections: [
//           SettingsSection(
//             titlePadding: EdgeInsets.all(20),
//             title: 'General',
//             tiles: [
//               SettingsTile(
//                 title: 'Language',
//                 subtitle: 'English',
//                 leading: Icon(Icons.language),
//                 onPressed: (BuildContext context) {},
//               ),
//               SettingsTile.switchTile(
//                 title: 'Use System Theme',
//                 leading: Icon(Icons.phone_android),
//                 switchValue: isSwitched,
//                 onToggle: (value) {
//                   setState(() {
//                     isSwitched = value;
//                   });
//                 },
//               ),
//             ],
//           ),
//           SettingsSection(
//             titlePadding: EdgeInsets.all(20),
//             title: 'Privacy',
//             tiles: [
//               SettingsTile(
//                 title: 'Security',
//                 subtitle: 'Fingerprint',
//                 leading: Icon(Icons.lock),
//                 onPressed: (BuildContext context) {},
//               ),
//               SettingsTile.switchTile(
//                 title: 'Use fingerprint',
//                 leading: Icon(Icons.fingerprint),
//                 switchValue: true,
//                 onToggle: (value) {},
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
