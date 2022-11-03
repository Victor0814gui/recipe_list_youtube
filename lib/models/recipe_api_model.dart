import 'dart:convert';

import 'package:recipe_list_youtube/models/recipe_model.dart';
import 'package:http/http.dart' as http;


class RecipesApiModel{

  static Future<List<RecipeModel>> getRecipeModel() async{
    var uri  = Uri.https(
      'yummly2.p.rapidapi.com',
      '/feeds/list',
      {
        'limit': '18',
        'start': '0',
        'tag': 'list.recipe.popular',
      }

    );

    final response = await http.get(
      uri,
      headers:{
         'X-RapidAPI-Key': 'ff970d4f21mshc2cc49770eda00fp196176jsn533ba4b9f16e',
         'X-RapidAPI-Host': 'yummly2.p.rapidapi.com',
         'useQueryString': 'true',
      }
    );

    Map data = jsonDecode(response.body);
    List temp = [];

    for(var i in data['feed']){
      temp.add(i['content']['details']);
    }

    return RecipeModel.recipesFromSnapshot(temp);
  }

}