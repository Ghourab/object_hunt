import 'package:cloud_firestore/cloud_firestore.dart';

class Players{
  String hiderName;
  String seekerName;
  int hiderScore;
  int seekerScore;
  Players(
      {required this.hiderName,
      required this.seekerName,
      required this.hiderScore,
      required this.seekerScore});

      factory Players.fromSnapshot(DocumentSnapshot snapshot) {
    return Players(
        hiderName: snapshot.get('Hider'),
        seekerName: snapshot.get('Seeker'),
        hiderScore: snapshot.get('hiderScore'),
        seekerScore: snapshot.get('seekerScore'));
  }
}