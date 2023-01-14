import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String username;
  String email;
  String image;
  String dob;
  User(
      {required this.username,
      required this.email,
      required this.image,
      required this.dob});
  factory User.fromJson(Map<String, dynamic> json) => User(
      username: json['username'],
      email: json['email'],
      image: json['image'],
      dob: json['dob']);

  Map<String, dynamic> toJson() =>
      {'username': username, 'email': email, 'image': image, 'dob': dob};

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    return User(
        username: snapshot.get('username'),
        email: snapshot.get('email'),
        image: snapshot.get('image'),
        dob: snapshot.get('dob'));
  }
}
