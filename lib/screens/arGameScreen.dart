import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:object_hunt/screens/readyScreen.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'dart:async';
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
            title: Text('Winner'),
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
  bool _isVisible = false;
  List<dynamic> locations = [0];

  int timeLeft = 5;
  int timeLeft2 = 5;
  void _startCount() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      if (timeLeft > 0) {
        setState(() {
          //change value of stuff
          timeLeft--;
        });
      } else {
        timer.cancel();
        if (role == 'Hider') {
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: const Text('Switch to Seeker'),
                    content: Text("Time is Up!!"),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          role = 'Seeker';
                          readyScreen(context);
                        },
                      ),
                    ],
                  ));
        }
      }
    });
  }

  void _startCount2() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      if (timeLeft2 > 0) {
        setState(() {
          //change value of stuff
          timeLeft2--;
        });
      } else {
        timer.cancel();
        _showWinner();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _startCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: role == 'Seeker'
            ? Column(children: [
                Text('Score ${seekerScore.toString()}'),
                Text('time: ${timeLeft2.toString()}'),
              ])
            : Text('time: ${timeLeft.toString()}'),
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
                  _startCount2();
                });
                _isVisible = true;
              }
            : _showWinner,
        child: Center(child: Text('End Turn')),
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

  void _addSphere() {
    final material = ArCoreMaterial(
      color: Colors.yellow,
    );
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.1,
    );
    final sphereNode = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0, 0, -1.5),
    );
    arCoreController?.addArCoreNode(sphereNode);
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

    // final moonMaterial = ArCoreMaterial(color: Colors.blue);

    // final moonShape = ArCoreSphere(
    //   materials: [moonMaterial],
    //   radius: 0.03,
    // );

    // final moon = ArCoreNode(
    //   shape: moonShape,
    //   position: vector.Vector3(0.2, 0, 0),
    //   rotation: vector.Vector4(0, 0, 0, 0),
    // );

    // final earthMaterial = ArCoreMaterial(
    //     color: Color.fromARGB(120, 66, 134, 244),);

    // final earthShape = ArCoreCube(
    //   materials: [earthMaterial],
    //   size: vector.Vector3(0.5, 0.5, 0.5),
    // );

    // final earth = ArCoreNode(
    //     shape: earthShape,
    //     children: [moon],
    //     position: hit.pose.translation + vector.Vector3(0.0, 1.0, 0.0),
    //     rotation: hit.pose.rotation);

    // arCoreController!.addArCoreNodeWithAnchor(earth);
    // arCoreController!.addArCoreNode(earth);
    // arCoreController!.addArCoreNodeWithAnchor(moon);
    // arCoreController!.addArCoreNode(moon);
    // arCoreController?.addArCoreNode(earth);
    // arCoreController?.addArCoreNode(moon);
  }
}
