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

  void openAddMealModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => const Dialog(child: AddOrUpdateMealModal()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: IconButton(
            tooltip: 'Add meal',
            iconSize: 40,
            splashColor: Colors.amber,
            onPressed: () => openAddMealModal(context),
            icon: const Icon(
              Icons.add,
              size: 40,
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: BlocBuilder<DatesBloc, DatesState>(
            builder: (context, state) {
              Date date =
                  state.dates.firstWhere((element) => element.date == dateId);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: Navigator.of(context).pop,
                    child: const Icon(Icons.arrow_back_ios),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
