import 'package:flutter/material.dart';
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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(20),
              child: SizedBox(
                height: 300,
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=580&q=80"),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text("mario")
                          ],
                        ),
                        leading: Text(
                          "#${index + 1}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                            "Rs.${(200000 / (index + 1)).toString().substring(0, 5)}",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                          thickness: 1,
                          color: Colors.purple,
                          indent: 10,
                          endIndent: 10,
                        ),
                    itemCount: 3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
