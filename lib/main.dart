import 'package:flutter/material.dart';
import 'package:recipe_app/data/data_source/recipe/recipe_data_source_impl.dart';
import 'package:recipe_app/presentation/component/dish_card.dart';
import 'package:recipe_app/presentation/main/home/home_action.dart';

import 'data/model/recipe_model.dart';
import 'data/repository/recipe_repository/recipe_repository_impl.dart';
import 'domain/use_case/get_recipe_use_case.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NewRecipeCard Test',
      home: const RecipeCardTestScreen(),
    );
  }
}

class RecipeCardTestScreen extends StatefulWidget {
  const RecipeCardTestScreen({super.key});

  @override
  State<RecipeCardTestScreen> createState() => _RecipeCardTestScreenState();
}

class _RecipeCardTestScreenState extends State<RecipeCardTestScreen> {
  late final GetRecipeUseCase _useCase;
  late final Recipe _recipe;

  @override
  void initState() {
    super.initState();
    final repository = RecipeRepositoryImpl(RecipeDataSourceImpl());
    _useCase = GetRecipeUseCase(repository);
    _loadRecipe();
  }

  Future<void> _loadRecipe() async {
    final result = await _useCase.execute();
    if (result.isNotEmpty) {
      setState(() {
        _recipe = result.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NewRecipeCard 테스트')),
      body: Center(
        child: DishCard(
          recipe: _recipe,
          isBookMarked: _recipe!.isBookMarked,
          onTap: () {
            print('카드 클릭됨!');
          },
          onAction: (HomeAction action) {},
        ),
      ),
    );
  }
}
