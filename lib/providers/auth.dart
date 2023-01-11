import'dart:async';
import 'dart:convert';
import 'dart:io';

//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';



class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;

  bool get isAuth{
    //if token != to null isAuth = true
    print(token);
    return token!=null;

  }
 Future<Object> getUser() async {
    // return await FirebaseFirestore.instance.collection('users').doc(_userId).get();
    
    final DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc('Btsaw9rU1oQb7YyUvV7HHcGoYoq2').get();
    return documentSnapshot;
  }



  String? get token{
    if(_expiryDate!=null&& _expiryDate!.isAfter(DateTime.now()) && _token!=null){
      return _token;
    }
    return null;
  }

  Future<void> signup(String email, String password,String name,String dob,File image) async {
    notifyListeners();
  return _authenticate(email, password,'signUp',name:name,dob:dob,image:image);
  }

  Future<void> login(String email, String password) async {

   return _authenticate(email, password,'signInWithPassword');
  }

  Future<void> editUser(String email,String password) async{
     final url =
        Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:update?key=AIzaSyBB_JJRuXI1-1BaTHTYcipDTy44cQps4QY');
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
  }catch(e){throw e;}
  }
Future<void> viewData() async{
     final url =
        Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=AIzaSyBB_JJRuXI1-1BaTHTYcipDTy44cQps4QY');
        try {
      final response = await http.post(
      url,
      
    );
    final responseData =json.decode(response.body);
    
    if(responseData['error']!=null){
      throw HttpException(responseData['error']['message']);
    }
    return responseData;
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

       await FirebaseFirestore.instance.collection('users').doc(_userId).set({
        'username':name,
        'email':email,
        'dob':dob,
        'image_url':url,
      });
    }
    _autoLogout();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final userData =json.encode({'token':_token,'userId':_userId,'expiryDate': _expiryDate!.toIso8601String()});
    prefs.setString('userData', userData);
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

  Future<bool?> autoLogin() async{
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
    notifyListeners();
    _autoLogout();
    return true;
  }

}
