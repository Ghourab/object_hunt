import 'package:cloud_firestore/cloud_firestore.dart';

class PlayersHighscores2{
String hiderName;
  String seekerName;
  int hiderScore;
  int seekerScore;
  PlayersHighscores2(
      {required this.hiderName,
      required this.seekerName,
      required this.hiderScore,
      required this.seekerScore});

      factory PlayersHighscores2.fromSnapshot(DocumentSnapshot snapshot) {
    return PlayersHighscores2(
        hiderName: snapshot.get('hiderName'),
        seekerName: snapshot.get('SeekerName'),
        hiderScore: snapshot.get('hiderScore'),
        seekerScore: snapshot.get('seekerScore'));
  }
}