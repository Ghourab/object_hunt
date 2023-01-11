import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:object_hunt/providers/user_provider.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  bool showPassword = false;
  TextEditingController name= TextEditingController();
  TextEditingController email= TextEditingController();




  @override
  Widget build(BuildContext context) {
    final data=ref.watch(userDataProvider);
    // final privateData=ref.watch(userPrivateDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Object Hunt'),
      ),
      body: data.when( data: (doc) {  
      name.text=doc.get('username');
      email.text=doc.get('email');
      
    
        return Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Text(
              "Edit Profile",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.account_circle,
                        size: 100,
                      )),
                ],
              ),
            ),
            buildTextField("Full Name", name, false),
            buildTextField("E-mail",name, false),
            buildTextField("Password",name, true),
            buildTextField("Location",name, false),
            SizedBox(
              height: 35,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              OutlinedButton(
                onPressed: () {},
                child: Text("CANCEL",
                    style: TextStyle(
                        fontSize: 14, letterSpacing: 2.2, color: Colors.black)),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "SAVE",
                  style: TextStyle(
                      fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                ),
              )
            ]),
          ],
        ),
      );
      }, loading:()=> Center(child: CircularProgressIndicator()),
      error: (stacktrace, context)=>Text('Shihab'),), 
    );
  }

  Widget buildTextField(
      String labelText,TextEditingController controller, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: controller,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
            
                      setState(() {
                        showPassword = !showPassword;
                        
                        
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
