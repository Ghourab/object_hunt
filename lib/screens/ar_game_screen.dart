import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:object_hunt/screens/ready_screen.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../models/players.dart';
import '../providers/players_provider..dart';

class ArGameScreen extends ConsumerStatefulWidget {
  @override
  _ArGameScreenState createState() => _ArGameScreenState();
}

class _ArGameScreenState extends ConsumerState<ArGameScreen> {
  void _showWinner() async {
    var userID = FirebaseAuth.instance.currentUser!.uid;
    int newHiderHighScore = hiderScore;
    int newSeekerHighScore = seekerScore;

    await FirebaseFirestore.instance.collection('players').doc(userID).update({
      'hiderScore': hiderScore,
      'seekerScore': seekerScore,
    });
    final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('players')
        .doc(userID)
        .get();
    Players players = Players.fromSnapshot(documentSnapshot);
    ref.read(playersDataProivder.notifier).state = players;
    String newHiderName = players.hiderName;
    String newSeekerName = players.seekerName;
    final DocumentSnapshot documentSnapshot2 = await FirebaseFirestore.instance
        .collection('highScore')
        .doc(userID)
        .get();
    if (documentSnapshot2.exists) {
      var hiderHighScore = documentSnapshot2.get('hiderScore');
      var seekerHighScore = documentSnapshot2.get('seekerScore');
      var hiderNameHighScore = documentSnapshot2.get('hiderName');
      var seekerNameHighScore = documentSnapshot2.get('SeekerName');
      if (hiderHighScore > players.hiderScore) {
        newHiderHighScore = hiderHighScore;
        newHiderName = hiderNameHighScore;
      }
      if (seekerHighScore > players.seekerScore) {
        newSeekerHighScore = seekerHighScore;
        newSeekerName = seekerNameHighScore;
      }
      await FirebaseFirestore.instance
          .collection('highScore')
          .doc(userID)
          .update({
        'SeekerName': newSeekerName,
        'hiderName': newHiderName,
        'hiderScore': newHiderHighScore,
        'seekerScore': newSeekerHighScore,
      });
    } else {
      await FirebaseFirestore.instance.collection('highScore').doc(userID).set({
        'SeekerName': players.seekerName,
        'hiderName': players.hiderName,
        'hiderScore': hiderScore,
        'seekerScore': seekerScore,
      });
    }
    if (hiderScore > seekerScore) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
            title: Text('Congratulations the winner is ' + players.hiderName),
            content: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Hider name: ' + players.hiderName),
                  Text('Hider score: ' + players.hiderScore.toString()),
                  Text('Seeker name: ' + players.seekerName),
                  Text('Seeker score: ' + players.seekerScore.toString())
                ]),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).popUntil((route) => route.isFirst);
                },
                child: Text('Okay'),
              )
            ]),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
            title: Text('Winner is ' + players.seekerName + '!'),
            content: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Hider name: ' + players.hiderName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              Color.fromARGB(255, 255, 2, 2).withOpacity(0.8))),
                  Text('Hider score: ' + players.hiderScore.toString()),
                  Text('Seeker name: ' + players.seekerName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              Color.fromARGB(255, 255, 2, 2).withOpacity(0.8))),
                  Text('Seeker score: ' + players.seekerScore.toString())
                ]),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).popUntil((route) => route.isFirst);
                },
                child: Text('Okay'),
                style: TextButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 255, 255, 255),
                  backgroundColor:
                      Color.fromARGB(255, 255, 0, 0), // Background Color
                ),
              )
            ]),
      );
    }
  }

  void readyScreen(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return ReadyScreen();
        },
      ),
    );
  }

  void popScreen(BuildContext ctx) {
    Navigator.of(ctx).pop(ctx);
  }

  ArCoreController? arCoreController;
  var role = 'Hider';
  int seekerScore = 0;
  int hiderScore = 0;

  List<dynamic> locations = [0];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: role == 'Seeker'
            ? Column(children: [
                Text('Score ${seekerScore.toString()}'),
                Countdown(
                  // controller: _controller,
                  seconds: 40,
                  build: (_, double time) => Text(
                    time.toString(),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  interval: Duration(milliseconds: 100),
                  onFinished: () {
                    _showWinner();
                  },
                ),
                //   Text('time: ${timeLeft2.toString()}'),
              ])
            : Countdown(
                // controller: _controller,
                seconds: 40,
                build: (_, double time) => Text(
                  time.toString(),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                interval: Duration(milliseconds: 100),
                onFinished: () {
                  role = 'Seeker';
                  readyScreen(context);
                  setState(() {});
                },
              ),
        title: const Text('Object Hunt'),
        backgroundColor: Colors.red,
      ),
      body: ArCoreView(
        onArCoreViewCreated:
            role == 'Hider' ? _onArCoreViewCreated : _onArCoreViewCreated2,
        enableTapRecognizer: true,
        enableUpdateListener: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: role == 'Hider'
            ? () {
                role = 'Seeker';
                readyScreen(context);
                setState(() {
                  // _startCount2();
                });
              }
            : _showWinner,
        child: Icon(Icons.exit_to_app),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    arCoreController!.onPlaneTap = _handleOnPlaneTap;
    arCoreController!.onNodeTap = (name) => onTapHandler(name);
  }

  void _onArCoreViewCreated2(ArCoreController controller) {
    arCoreController = controller;

    arCoreController!.onNodeTap = (name) => onTapHandler(name);
  }

  void onTapHandler(String name) {
    if (role == 'Seeker') {
      arCoreController?.removeNode(nodeName: '$name');
      seekerScore += 10;
      hiderScore -= 10;
    }
    setState(() {});
  }

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    if (role == 'Hider') {
      final hit = hits.first;
      final material = ArCoreMaterial(
        color: Colors.red,
      );
      final sphere = ArCoreSphere(
        materials: [material],
        radius: 0.1,
      );

      final sphereNode = ArCoreNode(
        shape: sphere,
        position: hit.pose.translation,
      );
      arCoreController?.addArCoreNode(sphereNode);
      locations.add(hit.pose.translation);

      hiderScore += 10;
    }
  }
}
