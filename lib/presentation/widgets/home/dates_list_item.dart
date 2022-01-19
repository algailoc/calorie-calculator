import 'package:calorie_calculator/domain/entities/date.dart';
import 'package:calorie_calculator/presentation/bloc/dates_bloc.dart';
import 'package:calorie_calculator/presentation/screens/day/day_page.dart';
import 'package:calorie_calculator/utils/date_converters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatesListItem extends StatelessWidget {
  final String dateId;
  const DatesListItem(this.dateId, {Key? key}) : super(key: key);

  double getDailyCalories(Date date) {
    double result = 0;
    for (var meal in date.meals) {
      result += meal.calories;
    }
    return result;
  }

  void navigateToDayScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DayPage(dateId)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: BlocBuilder<DatesBloc, DatesState>(
        builder: (context, state) {
          Date date = state.dates.firstWhere((el) => el.date == dateId);
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(date.date),
                  Text(mapWeekDayToString(stringToDate(date.date).weekday)),
                ],
              ),
              const Spacer(),
              Text('Overall: ${getDailyCalories(date)} kcal'),
              GestureDetector(
                onTap: () => navigateToDayScreen(context),
                child: const RotatedBox(
                  quarterTurns: 2,
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
