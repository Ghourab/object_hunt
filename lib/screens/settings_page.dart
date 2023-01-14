//  import 'package:flutter/material.dart';
// import 'package:settings_ui/settings_ui.dart';

// class Settingspage extends StatefulWidget {
//   Settingspage({Key? key}) : super(key: key);
//   @override
//   _SettingspageState createState() => _SettingspageState();
// }

// class _SettingspageState extends State<Settingspage> {
//   bool isSwitched = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Settings"),
//       ),
//       body: SettingsList(
//         sections: [
//           SettingsSection(
//             : EdgeInsets.all(20),
//             title: Text('General'),
//             tiles: [
//               SettingsTile(
//                 title: Text('Language'),
//                 description: Text('English'),
//                 leading: Icon(Icons.language),
//                 onPressed: (BuildContext context) {},
//               ),
//               SettingsTile.switchTile(
//                 title: Text('Use System Theme'),
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
//             title: Text('Privacy'),
//             tiles: [
//               SettingsTile(
//                 title: Text('Security'),
//                 subtitle: 'Fingerprint',
//                 leading: Icon(Icons.lock),
//                 onPressed: (BuildContext context) {},
//               ),
//               SettingsTile.switchTile(
//                 title: Text('Use fingerprint'),
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
