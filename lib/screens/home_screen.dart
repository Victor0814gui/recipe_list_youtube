import 'package:flutter/material.dart';
import 'package:recipe_list_youtube/models/recipe_model.dart';
import 'package:recipe_list_youtube/models/recipe_api_model.dart';
import 'package:recipe_list_youtube/screens/widgets/recipe_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late List<RecipeModel> recipes;
  bool isLoading = true;

  @override
  void initState(){
    super.initState();
    getRecipes();
  }

  Future<void> getRecipes() async {
    recipes = await RecipesApiModel.getRecipeModel();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
       title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.restaurant_menu,
              color: Colors.black,
            ),
            SizedBox(width: 10),
            Text(
              'Food Recipe',
              style: TextStyle(
                color: Colors.black,
              ),
            )
          ]
       ),
       backgroundColor: Colors.white,
      ),
      body: isLoading 
        ? const Center(
          child: CircularProgressIndicator(),
        )
        : ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (context,index){
            return RecipeCard(
              title: recipes[index].name,
              rating:recipes[index].rating.toString() ,
              cookTime: recipes[index].totalTime,
              thumbnailUrl: recipes[index].images,
            );
          }
        )
    );
  }
}
