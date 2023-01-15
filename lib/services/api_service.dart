import 'package:http/http.dart' as http;

import '/models/api_model.dart';

class ApiServices {
  Future<List<Giveaway>> getModel() async {
    var client = http.Client();
    var uri =
        Uri.parse('https://www.gamerpower.com/api/giveaways');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      String jsonString = response.body;
      return  welcomeFromJson(jsonString);
    }
    return [];
  }
}
