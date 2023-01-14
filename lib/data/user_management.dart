import 'package:cloud_firestore/cloud_firestore.dart';

class UserManager {

  Future setUser( String userId, String name, String email, String dob, String url ) async {
   await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'username':name,
        'email':email,
        'dob':dob,
        'image_url':url,
      });
}


}