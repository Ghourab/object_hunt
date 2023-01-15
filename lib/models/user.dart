import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String username;
  String email;
  String image;
  String dob;
  Users(
      {required this.username,
      required this.email,
      required this.image,
      required this.dob});
  factory Users.fromJson(Map<String, dynamic> json) => Users(
      username: json['username'],
      email: json['email'],
      image: json['image'],
      dob: json['dob']);

  Map<String, dynamic> toJson() =>
      {'username': username, 'email': email, 'image': image, 'dob': dob};

  factory Users.fromSnapshot(DocumentSnapshot snapshot) {
    return Users(
        username: snapshot.get('username'),
        email: snapshot.get('email'),
        image: snapshot.get('image_url'),
        dob: snapshot.get('dob'));
  }
}
