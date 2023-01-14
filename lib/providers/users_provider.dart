import 'package:flutter/material.dart';

import '../models/user.dart';
class Users_provider with ChangeNotifier{
  List<User> _items= [User(
      username: 'Ahmed Sameh',
     
      email: 'ahmed@gmail.com',
    
      dob: '06/08/2001',
      image: 'http://'
    )];

  List<User> get items{
    //copy of the list cause I don't want to change the list
    return [..._items];
  }

  void addUser(){
    // _items.add(value);
    notifyListeners();
  }
}