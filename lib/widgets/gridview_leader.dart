import 'package:flutter/material.dart';

class GridViewLeader extends StatelessWidget {
  const GridViewLeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
         
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
          // separatorBuilder: (context, index) => Divider(
          //       thickness: 1,
          //       color: Colors.purple,
          //       indent: 10,
          //       endIndent: 10,
          //     ),
          itemCount: 3),
    );
  }
}
