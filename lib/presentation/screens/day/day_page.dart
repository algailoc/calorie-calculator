import 'package:calorie_calculator/domain/entities/date.dart';
import 'package:calorie_calculator/presentation/bloc/dates_bloc.dart';
import 'package:calorie_calculator/presentation/widgets/day/add_meal_modal.dart';
import 'package:calorie_calculator/presentation/widgets/day/meal_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayPage extends StatelessWidget {
  final String dateId;

  const DayPage(this.dateId, {Key? key}) : super(key: key);

  double getDailyCalories(Date date) {
    double result = 0;
    for (var meal in date.meals) {
      result += meal.calories;
    }
    return result;
  }

  void openAddMealModal(BuildContext context, String date) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(child: AddOrUpdateMealModal(date: date)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<DatesBloc, DatesState>(
        builder: (context, state) {
          Date date =
              state.dates.firstWhere((element) => element.date == dateId);
          return Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: IconButton(
                tooltip: 'Add meal',
                iconSize: 40,
                splashColor: Colors.amber,
                onPressed: () => openAddMealModal(context, date.date),
                icon: const Icon(
                  Icons.add,
                  size: 40,
                )),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: Navigator.of(context).pop,
                        child: const Icon(Icons.arrow_back_ios),
                      ),
                      Text(
                        date.date,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      const SizedBox(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                      itemCount: date.meals.length,
                      shrinkWrap: true,
                      itemBuilder: (ctx, idx) => MealListItem(date.meals[idx])),
                  const SizedBox(height: 20),
                  Text(
                    'Overall: ${getDailyCalories(date).toString()} kcal',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
