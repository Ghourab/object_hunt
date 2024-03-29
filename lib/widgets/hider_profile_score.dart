import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/players_highscores.dart';
import '../providers/players_provider..dart';

class ProfileScoreHider extends ConsumerStatefulWidget {
  const ProfileScoreHider({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScoreHider> createState() => _ProfileScoreState();
}

class _ProfileScoreState extends ConsumerState<ProfileScoreHider> {
  
  @override
  Widget build(BuildContext context) {
    var hiderData = ref.watch(getHiderData);
 
return hiderData.when(data:(data) { 
var player= PlayersHighscores.fromSnapshot(data.docs[0]) ;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Container(
          padding: EdgeInsets.only(top: 40),
          height: 330,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              )),
          child: Column(children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1331&q=80"),
                  radius: 50,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              player.hiderName,
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text("45",
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w300,
                          color: Colors.white.withOpacity(0.9),
                        )),
                    Text(
                      "Level",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "#1",
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w300,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    Text("Rank",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ))
                  ],
                ),
              ],
            ),
          ]),
        );
      },
    );
    
},loading:()=> Center(child: CircularProgressIndicator()),
      error: (stacktrace, context)=>Text('Sameh'),);
  }
}
