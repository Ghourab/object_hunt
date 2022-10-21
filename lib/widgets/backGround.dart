import 'package:flutter/material.dart';

class BackGround extends StatelessWidget {

final Widget widget;

  BackGround( this.widget );

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/backgroundImportant.gif"),
              fit: BoxFit.cover),
        ),
        child: widget,
        );
  }
}