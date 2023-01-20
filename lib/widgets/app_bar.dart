import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text('Object Hunt'),
        toolbarOpacity: 40,
      );
  }
}