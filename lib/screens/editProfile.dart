import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:object_hunt/providers/user_provider.dart';
import 'package:provider/provider.dart' as provider;

import '../data/user_management.dart';
import '../providers/auth.dart';
import '../widgets/user_picker_image2.dart';


class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  bool showPassword = true;
  TextEditingController name= TextEditingController();
  TextEditingController email= TextEditingController();
TextEditingController dateInput = TextEditingController();
TextEditingController password = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey();
 File? _userImageFile;
Map<String, dynamic> _changedData = {
    'email': '',
    'password': '',
    'name': '',
    'dob': '',
    'image':'',
  };

  UserManager? manager;

 final  user =  FirebaseAuth.instance.currentUser!;
  void _pickedImage(File image){
    _userImageFile=image;
   _changedData['Image']=_userImageFile;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occured!.'),
        content: Text(message),
        actions: <Widget>[
          TextButton(onPressed: (){
            Navigator.of(ctx).pop();
          }, child: Text('Okay'),)
        ]
      ),
    );
  }


void _editedSuccessfuly(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Edited Successfuly!.'),
        content: Text(message),
        actions: <Widget>[
          TextButton(onPressed: (){
            Navigator.of(ctx).pop();
          }, child: Text('Okay'),)
        ]
      ),
    );
  }
  Future<void> _submit(WidgetRef ref) async {
    if (!_formKey.currentState!.validate() ) {
      // Invalid!
      return;
    }
    if(_userImageFile == null){

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.red, content:Text('Please pick an image.'),),);
    }
    _formKey.currentState!.save();
    try{
      print(_changedData);
      
    }on HttpException catch (error) {
      var errorMessage = 'Authentication Failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid Password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not edit data. please try again later.';
  
    }
final refr = FirebaseStorage.instance.ref().child('user_image').child(user.uid + '.jpg');
      print(refr.root);
      print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
      print(_userImageFile);
      print(_changedData);
        await refr.putFile(_userImageFile!).whenComplete((){});
    print(_changedData);
      final  url= await refr.getDownloadURL();
     await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'username':_changedData['name'],
        'email':_changedData['email'],
        'dob':_changedData['dob'],
        'image_url':url,
      });
                    await FirebaseAuth.instance.currentUser!.updateEmail(_changedData['email']);
                    await FirebaseAuth.instance.currentUser!.updatePassword(_changedData['password']);
                     FirebaseAuth.instance.signOut();
       provider.Provider.of<Auth>(context, listen: false).logout();
                print(_changedData);     
   var editedData=ref.read(newUserDataProivder.notifier).state;
    editedData!.username=_changedData['name'];
    editedData.email=_changedData['email'];
    editedData.dob=_changedData['dob'];
    editedData.image=url;
    print(_changedData);
 
    _editedSuccessfuly('The Account is edited with the new credintials');
    
    }
@override
void initState() {
    // TODO: implement initState
       
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
 var data=ref.watch(newUserDataProivder);
  name.text=data!.username;
  email.text=data.email;
  dateInput.text=data.dob;
    // final privateData=ref.watch(userPrivateDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Object Hunt'),
      ),
      body:  
   
      
    
     Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: Form(
          
          key: _formKey,
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
                    UserPickerImage2(_pickedImage,data.image),
                    
                  ],
                ),
              ),
              buildTextField(labelText: "Full Name", controller: name,isPasswordTextField:  false),
              buildTextField(labelText:"E-mail",controller:email,isPasswordTextField: false),
              buildTextField(labelText:"Password",controller:password,isPasswordTextField: true),
              buildTextField(labelText:"Verify Password", isPasswordTextField:true),
              TextFormField(
                      controller: dateInput,
                      //editing controller of this TextField
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "Enter Date" //label text of field
                          ),
                      readOnly: true,
                      //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime.now());
        
                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                       
                            dateInput.text =
                                formattedDate; //set output date to TextField value.
                               
                        
                        } else {}
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid Date';
                        }
                        return null;
                      },
                      onSaved: (value) {
                          _changedData['dob'] = value!;
                      },
                    ),
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
                  onPressed:() =>  _submit(ref),
                  child: Text(
                    "SAVE",
                    style: TextStyle(
                        fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                  ),
                )
              ]),
            ],
          ),
        ),
      ),
    
    );
  }

  Widget buildTextField(
      {required String labelText,TextEditingController? controller, required bool isPasswordTextField}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
      validator: (value) {
        if(labelText=='E-mail'){
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  }
                  else if(labelText=='Password'){
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  }
                  else if(labelText=='Full Name'){
                       if (value!.isEmpty) {
                        return 'Invalid Name';
                      }
                      return null;
                  }
                  },
                  onSaved: (value) {
                    if(labelText=='E-mail'){
                    _changedData['email'] = value!;

                  }
                  else if(labelText=='Password'){
                    _changedData['password'] = value!;
                  }
                  else if(labelText=='Full Name'){
                    _changedData['name'] = value!;
                  }
                  },


                




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
