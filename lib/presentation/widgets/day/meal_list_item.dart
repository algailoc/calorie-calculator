import 'package:calorie_calculator/domain/entities/meal.dart';
import 'package:calorie_calculator/presentation/bloc/dates_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  Future<bool> swipeHandler(BuildContext context) async {
    return await showCupertinoDialog(
        context: context,
        builder: (ctx) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              height: 120,
              child: Column(
                children: [
                  const Text('Are you sure you want to delete this meal?'),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Confirm'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancel'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  void deleteMeal(BuildContext context) {
    BlocProvider.of<DatesBloc>(context).add(DeleteMealEvent(meal));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openAddMealModal(context),
      child: Dismissible(
        direction: DismissDirection.endToStart,
        onDismissed: (_) => deleteMeal(context),
        confirmDismiss: (_) => swipeHandler(context),
        key: GlobalKey(),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange),
              color: Colors.transparent),
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
      ),
    );
  }
}
