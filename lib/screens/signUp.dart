import 'package:flutter/material.dart';

import '../screens/signIn.dart';
import '../widgets/backGround.dart';


class SignUp extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void signInScreen(BuildContext ctx){
  Navigator.of(ctx).push(MaterialPageRoute(builder: (_){
    return SignIn();
  },),);
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
                    'Sign Up',
                    style: TextStyle(fontSize: 20,color: Colors.white,),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor:Colors.white,
                    labelText: 'User Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  
                  
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor:Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  obscureText: true,
                  controller: confirmPasswordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor:Colors.white,
                    labelText: 'Confirm password',
                  ),
                ),
              ),
              
              Container(
                  height: 60,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Sign up'),
                    onPressed: () {
                      print(nameController.text);
                      print(passwordController.text);
                      print(confirmPasswordController.text);
                    },
                  )
              ),
              Row(
                children: <Widget>[
                  const Text('Already have an account?',style:TextStyle(color:Colors.white),),
                  TextButton(
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: ()=>signInScreen(context),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          ),),
      ),);
  }
 
}
 
