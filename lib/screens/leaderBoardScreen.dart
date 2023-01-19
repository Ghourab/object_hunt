import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:object_hunt/models/players_highscores.dart';

import '../providers/players_provider..dart';
import '../widgets/gridview_leader.dart';
import '../widgets/listview_leader.dart';
import '../widgets/profileScore.dart';

class LeaderBoard extends ConsumerStatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  ConsumerState<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends ConsumerState<LeaderBoard> {


  @override
  Widget build(BuildContext context) {
      var choosedPropertyTypeToGetData = ref.watch(getHiderData);
 
return choosedPropertyTypeToGetData.when(data:(data) { 
var player= PlayersHighscores.fromSnapshot(data.docs[0]) ;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        // actions: [
        //   IconButton(onPressed: () {}, icon: Icon(Icons.share)),
        //   IconButton(onPressed: () {}, icon: Icon(Icons.person_add)),
        // ],
        title: Text(
          'Hider Scoreboard',
          style: TextStyle(fontSize: 29),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileScore(),
            SizedBox(
              height: 20,
            ),
            Text(
              "Leaderboard",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              //  margin: EdgeInsets.only(bottom: 150),
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(20),
              child: SizedBox(
                height: 300,
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  if (constraints.maxWidth > 600) {
                    return GridViewLeader();
                  } else {
                    return ListViewLeader();
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
    }, loading:()=> Center(child: CircularProgressIndicator()),
      error: (stacktrace, context)=>Text('Sameh'),);
  }
}
