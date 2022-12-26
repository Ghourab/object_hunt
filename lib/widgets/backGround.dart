import 'package:flutter/material.dart';

class BackGround extends StatelessWidget {

final Widget widget;

  BackGround( this.widget );

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: double.infinity,
        height: MediaQuery.of(context).size.height,
        // width: double.infinity,
        width: MediaQuery.of(context).size.width,

        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/backgroundImportant.gif"),
              fit: BoxFit.cover),
        ),
        child: widget,
        );
  }
}