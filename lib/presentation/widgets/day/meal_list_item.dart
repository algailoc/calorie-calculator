import 'package:calorie_calculator/domain/entities/meal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_meal_modal.dart';

class MealListItem extends StatelessWidget {
  final Meal meal;

  const MealListItem(this.meal, {Key? key}) : super(key: key);

  void openAddMealModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(child: AddOrUpdateMealModal(meal: meal)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange),
      ),
      child: GestureDetector(
        onTap: () => openAddMealModal(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              meal.name,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            Row(
              children: [
                Text(meal.portion),
                const Spacer(),
                Text('${meal.calories} kcal / ${meal.weight} g')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
