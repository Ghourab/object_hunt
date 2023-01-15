import'dart:async';
import 'dart:convert';
import 'dart:io';

//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:object_hunt/data/user_management.dart';
import 'package:object_hunt/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';
import '../models/user.dart';



class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;
  UserManager? manager;
  
  bool get isAuth{
    //if token != to null isAuth = true
    return token!=null;

  }
 Future<DocumentSnapshot> getUser() async {
    // return await FirebaseFirestore.instance.collection('users').doc(_userId).get();

    final  user = FirebaseAuth.instance.currentUser!;

    String id=user.uid;
    print(id);
    final DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    return documentSnapshot;
  }



  String? get token{
    if(_expiryDate!=null&& _expiryDate!.isAfter(DateTime.now()) && _token!=null){
      return _token;
    }
    return null;
  }

  Future<void> signup(String email, String password,String name,String dob,File image) async {
    
 
  return _authenticate(email, password,'signUp',name:name,dob:dob,image:image);
  }

  Future<void> login(WidgetRef ref,String email, String password) async {


   await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );
        // ref.read(userDataProviderRepository.notifier).state=Auth().getUser();
        Auth().getUser().then((value) {
        Users user = Users.fromSnapshot(value);
        ref.read(newUserDataProivder.notifier).state = user;
      });
        
            return _authenticate(email, password,'signInWithPassword');
  }
  

  Future<void> editUser(WidgetRef ref,String userId,String email, String password,String name,String dob,File image) async{

      final refr = FirebaseStorage.instance.ref().child('user_image').child(userId + '.jpg');

   
        await refr.putFile(image).whenComplete((){});

    
      final  url= await refr.getDownloadURL();
      await manager!.editUser(userId, name, email, dob, url);
                     FirebaseAuth.instance.currentUser!.updateEmail(email);
                     FirebaseAuth.instance.currentUser!.updatePassword(password);
           
   var editedData=ref.read(newUserDataProivder.notifier).state;
    editedData!.username=name;
    editedData.email=email;
    editedData.dob=dob;
    editedData.image=url;
  }
Future<String> getUserId(String token) async{
     final url =
        Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=AIzaSyBB_JJRuXI1-1BaTHTYcipDTy44cQps4QY');
        try {
      final response = await http.post(
      url,
      body: json.encode(
        {'idToken': token})
    );
    final responseData =json.decode(response.body);
    
    if(responseData['error']!=null){
      throw HttpException(responseData['error']['message']);
    }
    print(responseData['localId']);
    return responseData['localId'];
  }catch(e){throw e;}
  }

  
  Future<void> _authenticate(String email,String password, String urlSegment,{String? name,String? dob,File? image}) async{
     final url =
        Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBB_JJRuXI1-1BaTHTYcipDTy44cQps4QY');
    
    try {
      final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    final responseData =json.decode(response.body);
    if(responseData['error']!=null){
      throw HttpException(responseData['error']['message']);
    }
    
    _token=responseData['idToken'];
    _userId=responseData['localId'];
    
    _expiryDate= DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn']),),);

    // if(urlSegment=='signUp'){
    //    await FirebaseFirestore.instance.collection('users').add({
    //     'username':name,
    //     'email':email,
    //     'dob':dob,
    //   });
    // }

     if(urlSegment=='signUp'){
      final ref = FirebaseStorage.instance.ref().child('user_image').child(_userId! + '.jpg');

      await ref.putFile(image!).whenComplete(() {});

      final  url= await ref.getDownloadURL();
      print(_userId);
      print(name);
      print(email);
      print(dob);
      print(url);
       await FirebaseFirestore.instance.collection('users').doc(_userId).set({
        'username':name,
        'email':email,
        'dob':dob,
        'image_url':url,
      });
    }
    
    _autoLogout();

    if(urlSegment!='signUp'){
    final prefs = await SharedPreferences.getInstance();
    final userData =json.encode({'token':_token,'userId':_userId,'expiryDate': _expiryDate!.toIso8601String()});
    prefs.setString('userData', userData);
    }
    else{
      _token =null;
    }
    notifyListeners();
    }
    catch(error){
      throw error;
    }
  }

  Future<void> logout() async{
    _token=null;
    _userId=null;
    _expiryDate=null;
    if(_authTimer!=null){
      _authTimer!.cancel();
      _authTimer=null;
    }
    await FirebaseAuth.instance.signOut(

        );
    notifyListeners();
    final prefs =await SharedPreferences.getInstance();
    prefs.remove('userData');

  }

  void _autoLogout(){
    // if there was an exsisting timer it shall be canceled
    if(_authTimer!=null){
      _authTimer!.cancel();
    }
    final timeToExpiry=_expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer=Timer(Duration(seconds:timeToExpiry),logout);

  }

  Future<bool?> autoLogin(WidgetRef ref) async{
    final prefs= await SharedPreferences.getInstance();
     
        
    if(!prefs.containsKey('userData')){
      return false;
    }
    final extractedUserData= json.decode(prefs.getString('userData')!) ;
    final expiryDate= DateTime.parse(extractedUserData['expiryDate']);

    if(expiryDate.isBefore(DateTime.now())){
      return false;
    }
    _token=extractedUserData['token'];
    _userId=extractedUserData['userId'];
    _expiryDate=expiryDate;
    Auth().getUser().then((value) {
        Users user = Users.fromSnapshot(value);
        ref.read(newUserDataProivder.notifier).state = user;
      });
    notifyListeners();
    _autoLogout();
    return true;
  }

}
