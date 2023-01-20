import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:object_hunt/screens/instructions_screen.dart';

class Players extends StatefulWidget {
  const Players({Key? key}) : super(key: key);

  @override
  State<Players> createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
    TextEditingController hiderController=TextEditingController();

TextEditingController seekerController=TextEditingController();

  void instructionScreen(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return InstructionScreen();
        },
      ),
    );
  }

final GlobalKey<FormState> _formKey = GlobalKey();
 Future <void> _submit() async{
  _formKey.currentState!.save();
  var userID=FirebaseAuth.instance.currentUser!.uid;
  await FirebaseFirestore.instance.collection('players').doc(userID).set({
        'Hider':hiderController.text,
        'Seeker':seekerController.text,
        
      });
      
      instructionScreen(context);

}
  @override
  Widget build(BuildContext context) {

        final deviceSize = MediaQuery.of(context).size;
    return Scaffold(backgroundColor: Colors.black,
      appBar:   AppBar(
        backgroundColor: Colors.red,
        // actions: [
        //   IconButton(onPressed: () {}, icon: Icon(Icons.share)),
        //   IconButton(onPressed: () {}, icon: Icon(Icons.person_add)),
        // ],
        title: Text(
          "Pick Nicknames",
          style: TextStyle(fontSize: 29),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 8.0,
        child: Container(
          height:  260,
          constraints:
              BoxConstraints(minHeight: 260),
          width: deviceSize.width * 0.75,
          padding: EdgeInsets.all(16.0),
          child: Form(
         key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Hider name'),
                 controller: hiderController ,
                    
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Seeker name'),
                   controller: seekerController,
                    
                    
                 
                  ),
                 SizedBox(height: 50),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                      child:
                          Text('Save'),
                      onPressed: _submit,
                      
                    ),
                  
                ],
              ),
            ),
          ),
        ),
          ),
      ),    );
  }
}