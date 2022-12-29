

import 'dart:convert';
import 'package:http/http.dart' as http;



const myAPI = '9403ed93ad383865fbf47fbb8d597748';
const appIdAPI = 'ab9704c5';

late List logincomponents=[];

class Login {

  Future foodRecipe(String selectedFood) async {

  var url='https://api.edamam.com/api/recipes/v2?type=public&q=$selectedFood&app_id=$appIdAPI&app_key=$myAPI';
    http.Response response=await http.get(Uri.parse(url));

    if(response.statusCode==200) {//hits[0].recipe.ingredients
      var data = jsonDecode(response.body);
      foodComponents=data['hits'][0]['recipe']['ingredients'];
      return foodComponents;
    }
    else{
      ('Failed to load the ingredients');
     // print(response.statusCode);
    }
  }
}
