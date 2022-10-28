import 'package:flutter/material.dart';

import '../screens/signUp.dart';

class HomeButtons extends StatelessWidget {


void signUpScreen(BuildContext ctx){
  Navigator.of(ctx).push(MaterialPageRoute(builder: (_){
    return SignUp();
  },),);
}
  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(85.0),
            child: Column(
              children: <Widget>[
                
                SizedBox(height:400),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0,10.0),
                  child: SizedBox(
                    
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: ()=>signUpScreen(context),
                      child: Text('Sign up'),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                    ),
                  ),
                ),
                
              ],
            ),
          );
  }
}