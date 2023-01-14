import 'package:flutter/material.dart';
import '../widgets/gridview_leader.dart';
import '../widgets/listview_leader.dart';
import '../widgets/profileScore.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[200],
        // actions: [
        //   IconButton(onPressed: () {}, icon: Icon(Icons.share)),
        //   IconButton(onPressed: () {}, icon: Icon(Icons.person_add)),
        // ],
        title: Text(
          "Score Board",
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
  }
}
