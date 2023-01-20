import 'package:flutter/material.dart';

import '../widgets/seeker_gridview_leader.dart';
import '../widgets/seeker_listview_leader.dart';
import '../widgets/seeker_profile_score.dart';

class LeaderBoardSeeker extends StatefulWidget {
  const LeaderBoardSeeker({Key? key}) : super(key: key);

  @override
  State<LeaderBoardSeeker> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoardSeeker> {


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
          'Seeker Scoreboard',
          style: TextStyle(fontSize: 29),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileScoreSeeker(),
            SizedBox(
              height: 20,
            ),
            Text(
              "Seekers Leaderboard",
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
                    return GridViewLeaderSeeker();
                  } else {
                    return ListViewLeaderSeeker();
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
