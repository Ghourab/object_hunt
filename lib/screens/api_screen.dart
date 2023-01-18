import 'package:object_hunt/models/api_model.dart';

import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class APi extends StatefulWidget {
  APi({Key? key}) : super(key: key);

  @override
  State<APi> createState() => _APiState();
}

class _APiState extends State<APi> {
  List<Giveaway> posts = <Giveaway>[];

  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    posts = await ApiServices().getModel();

    setState(() {
      isLoaded = true;
    });
  }

  _launchURL(index) async {
    var url = posts[index].openGiveawayUrl.toString();
    print(url);
    final uri = Uri.parse(url);

    await launchUrl(uri);

    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giveaways'),
        backgroundColor: Colors.teal[200],
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 5,
                child: Column(
                  children: [
                    GestureDetector(
                      child: Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(posts[index].image.toString()),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              posts[index].title.toString(),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(posts[index].worth.toString()),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(posts[index].description.toString()),
                          )
                        ],
                      )),
                      onTap: () => _launchURL(index),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
