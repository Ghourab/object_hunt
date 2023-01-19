import 'package:cloud_firestore/cloud_firestore.dart';

class PlayersHighscores{
String hiderName;
  String seekerName;
  int hiderScore;
  int seekerScore;
  PlayersHighscores(
      {required this.hiderName,
      required this.seekerName,
      required this.hiderScore,
      required this.seekerScore});

      factory PlayersHighscores.fromSnapshot(DocumentSnapshot snapshot) {
    return PlayersHighscores(
        hiderName: snapshot.get('hiderName'),
        seekerName: snapshot.get('SeekerName'),
        hiderScore: snapshot.get('hiderScore'),
        seekerScore: snapshot.get('seekerScore'));
  }
}