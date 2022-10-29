import 'package:flutter/material.dart';

import '../data/database.dart';
import '../models/users.dart';
import '../screens/startScreen.dart';
import '../widgets/backGround.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
 
  @override
  State<SignIn> createState() => SignInState();
}
 
class SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
List<User> users=getUsersList();

  
  void startScreen(BuildContext ctx,User value){
  Navigator.of(ctx).push(MaterialPageRoute(builder: (_){
    return StartScreen(value:value);
  },),);
}
  void popScreen(BuildContext ctx){
  Navigator.of(ctx).pop(ctx);
}


 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Object Hunt'),
      ),
      body: BackGround(
         Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Join Now',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20,color: Colors.white),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor:Colors.white,
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor:Colors.white,
                    labelText: 'Password',
                  ),
                ),
              ),
             
              Container(
                  height: 60,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () {
                      
                      
                        users.forEach((element) {
                          print(element);
                          if(element.email == emailController.text && element.password == passwordController.text)
                          {
                            
                         
                          startScreen(context,element);
                          }
                      
                  }
    );
                    },
                  )
              ),
              Row(
                children: <Widget>[
                  const Text('Don\'t have an account?',style:TextStyle(color: Colors.white)),
                  TextButton(
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: ()=>popScreen(context),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          ),),
      ),);
  }
}