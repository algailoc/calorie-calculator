import 'package:calorie_calculator/domain/entities/date.dart';
import 'package:calorie_calculator/domain/entities/meal.dart';
import 'package:calorie_calculator/presentation/bloc/dates_bloc.dart';
import 'package:calorie_calculator/presentation/widgets/home/dates_list_item.dart';
import 'package:calorie_calculator/utils/date_converters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

List<Meal> getMockMeals(String date) {
  return [
    Meal(
        id: 'id',
        date: date,
        name: 'Картошка',
        calories: 100,
        weight: 150,
        portion: '1 тарелка'),
    Meal(
        id: 'id',
        date: date,
        name: 'Картошка',
        calories: 100,
        weight: 150,
        portion: '1 тарелка'),
    Meal(
        id: 'id',
        date: date,
        name: 'Картошка',
        calories: 100,
        weight: 150,
        portion: '1 тарелка'),
  ];
}

List<Date> mockDates = [
  Date(
      date: dateToString(DateTime.now().toLocal()),
      meals: getMockMeals(dateToString(DateTime.now().toLocal()))),
  Date(
      date: dateToString(
          DateTime.now().toLocal().subtract(const Duration(days: 1))),
      meals: getMockMeals(dateToString(
          DateTime.now().toLocal().subtract(const Duration(days: 1))))),
  Date(
      date: dateToString(
          DateTime.now().toLocal().subtract(const Duration(days: 2))),
      meals: getMockMeals(dateToString(
          DateTime.now().toLocal().subtract(const Duration(days: 2))))),
];

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<DatesBloc>(context).add(FetchDatesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<DatesBloc, DatesState>(
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: ListView.separated(
                          itemBuilder: (ctx, idx) {
                            return DatesListItem(state.dates[idx].date);
                          },
                          separatorBuilder: (ctx, idx) {
                            return Container(
                              width: double.infinity,
                              height: 2,
                              color: Colors.amber,
                            );
                          },
                          itemCount: state.dates.length))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
