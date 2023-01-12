// import 'package:flutter/material.dart';

// import '../screens/signUp.dart';

// class HomeButtons extends StatelessWidget {


// void signUpScreen(BuildContext ctx){
//   Navigator.of(ctx).push(MaterialPageRoute(builder: (_){
//     return SignUp();
//   },),);
// }
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//             padding: const EdgeInsets.only(bottom : 60.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: <Widget>[
                
//                 // SizedBox(height:400),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0,10.0),
//                   child: SizedBox(
                    
//                     height: (MediaQuery.of(context).size.height >= 375)?  50: 25,
//                     width: 200,
//                     child: ElevatedButton(
//                       onPressed: ()=>signUpScreen(context),
//                       child: Text('Sign up', style: TextStyle(fontSize: 15),),
//                       style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       )),
//                     ),
//                   ),
//                 ),
                
//               ],
//             ),
//           );
//   }
// }