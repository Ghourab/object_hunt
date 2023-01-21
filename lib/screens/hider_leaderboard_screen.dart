import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/hider_gridview_leader.dart';
import '../widgets/hider_listview_leader.dart';
import '../widgets/hider_profile_score.dart';

class LeaderBoardHider extends StatefulWidget {
  const LeaderBoardHider({Key? key}) : super(key: key);

  @override
  State<LeaderBoardHider> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoardHider> {

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
    super.initState();
  }

  @override
  void dispose() {
     SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitUp,
  ]);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

 


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
            ProfileScoreHider(),
            SizedBox(
              height: 20,
            ),
            Text(
              "Hiders Leaderboard",
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
                    return GridViewLeaderHider();
                  } else {
                    return ListViewLeaderHider();
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
    
  }
}
