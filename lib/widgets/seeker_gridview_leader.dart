import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_avatar/random_avatar.dart';

import '../models/players_highscores.dart';
import '../providers/players_provider..dart';

class GridViewLeaderSeeker extends ConsumerWidget {
  const GridViewLeaderSeeker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    var seekerData = ref.watch(getSeekerData);
 
return seekerData.when(data:(data) { 
    return Container(
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,mainAxisExtent: 70,
          ),
         
          
          itemBuilder: (context, index) {
            var player= PlayersHighscores.fromSnapshot(data.docs[index]) ;
            return ListTile(
              title: Row(
                children: [
                  randomAvatar(
                    DateTime.now().toIso8601String(),
                    height: 50,
                    width: 52,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                   Flexible(child: Text(player.seekerName))
                ],
              ),
              leading: Text(
                "#${index + 1}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                              "Score: ${player.seekerScore}",
                              style: TextStyle(fontWeight: FontWeight.bold)),
            );
          },
          // separatorBuilder: (context, index) => Divider(
          //       thickness: 1,
          //       color: Colors.purple,
          //       indent: 10,
          //       endIndent: 10,
          //     ),
          itemCount: data.size),
    );}
                ,loading:()=> Center(child: CircularProgressIndicator()),
      error: (stacktrace, context)=>Text('Sameh'),);
  }
}
