import 'package:flutter/material.dart';
import 'package:recipe_app/presentation/component/alert/add_pop_up.dart';
import 'package:recipe_app/presentation/component/tabs.dart';
import 'package:recipe_app/presentation/recipe_screen/recipe_screen_view_model.dart';

import '../../ui/color_styles.dart';
import '../../ui/text_styles.dart';
import '../component/alert/rating_dialog.dart';
import '../component/ingredient_list.dart';
import '../component/recipe_card.dart';
import '../too_small_button.dart';

class RecipeScreen extends StatelessWidget {
  final RecipeScreenViewModel viewModel;

  const RecipeScreen({super.key, required this.viewModel});

  void _showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 80),
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 170,
                child: RatingDialog(
                  title: 'Rate recipe',
                  actionName: 'Send',
                  onChange: (rating) {},
                ),
              ),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        actions: [
          AddPopup(
            onSelected: (value) {
              if (value == 'star') {
                _showRatingDialog(context);
              }
            },
            items: const [
              const PopupMenuItem(
                value: 'share',
                child: Row(
                  children: [
                    Icon(Icons.share, size: 18),
                    SizedBox(width: 8),
                    Text('Share'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'star',
                child: Row(
                  children: [
                    Icon(Icons.star, size: 18),
                    SizedBox(width: 8),
                    Text('Rate Recipe'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'review',
                child: Row(
                  children: [
                    Icon(Icons.reviews, size: 18),
                    SizedBox(width: 8),
                    Text('Review'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'bookmark',
                child: Row(
                  children: [
                    Icon(Icons.book, size: 18),
                    SizedBox(width: 8),
                    Text('Unsave'),
                  ],
                ),
              ),
            ],
          ),
        ],
        elevation: 0,
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          final state = viewModel.state;

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RecipeCard(
                    recipe: state.recipe!,
                    showBookMarked: true,
                    showTitle: false,
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 40,
                        child: Text(
                          state.recipe!.name,
                          maxLines: 2,
                          style: TextStyles.mediumBold.copyWith(fontSize: 14),
                        ),
                      ),
                      Spacer(),
                      Text(
                        '(13k Reviews)',
                        style: TextStyles.normalRegular.copyWith(
                          fontSize: 14,
                          color: ColorStyles.gray3,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Image.asset(
                        'assets/images/chefimage.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 8),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.recipe!.chef,
                            style: TextStyles.smallBold.copyWith(fontSize: 14),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_rounded,
                                size: 14,
                                color: ColorStyles.gray3,
                              ),
                              Text(
                                'Logos, Nigerio',
                                style: TextStyles.smallBold.copyWith(
                                  fontSize: 14,
                                  color: ColorStyles.gray3,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      const TooSmallButton(text: 'Follow'),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Tabs(
                    labels: ['Ingredient', 'Procedure'],
                    selectedIndex: state.isIngredientSelected ? 0 : 1,
                    onChanged: (index) {
                      if (index == 0) {
                        viewModel.selectIngredientTab();
                      } else {
                        viewModel.selectProcedureTab();
                      }
                    },
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Image.asset('assets/images/Icon.png'),
                      const SizedBox(width: 8),
                      Text(
                        '1 serve',
                        style: TextStyles.smallRegular.copyWith(
                          fontSize: 11,
                          color: ColorStyles.gray3,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${state.ingredients.length} items',
                        style: TextStyles.smallRegular.copyWith(
                          fontSize: 11,
                          color: ColorStyles.gray3,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  if (state.isIngredientSelected)
                    IngredientList(recipe: state.recipe!),
                  if (!state.isIngredientSelected) Text('준비중'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
