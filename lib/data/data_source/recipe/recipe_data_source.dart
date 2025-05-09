import '../../model/recipe_model.dart';

abstract interface class RecipeDataSource {
  Future<List<Recipe>> getRecipes();

  Future<List<Recipe>> searchRecipes(String keyword);
}
