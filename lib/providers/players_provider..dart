import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/players.dart';

final playersDataProivder = StateProvider<Players?>((ref) {
  return null;
});

final getHiderData = StreamProvider((ref) {
  return FirebaseFirestore.instance.collection('highScore').orderBy('hiderScore',descending: true).
  snapshots();
});

final getSeekerData = StreamProvider((ref) {
  return FirebaseFirestore.instance.collection('highScore').orderBy('seekerScore',descending: true).
  snapshots();
});