import 'package:calorie_calculator/domain/entities/date.dart';
import 'package:calorie_calculator/domain/entities/meal.dart';
import 'package:calorie_calculator/main.dart';

abstract class LocalDataSource {
  Future<List<Date>> getDates();
  Future<void> addMeal(Meal meal);
  Future<void> updateMeal(Meal meal);
}

class LocalDataSourceImpl extends LocalDataSource {
  @override
  Future<List<Date>> getDates() async {
    List<Date> result = [];

    final List<Map<String, Object?>> datesRows = await database!.query('Dates');
    final List<Map<String, Object?>> mealsRows = await database!.query('Meals');
    for (var date in datesRows) {
      List<Meal> meals = [];
      for (var item in mealsRows) {
        Meal meal = Meal.fromJson(item);
        if (meal.date == date['date']) {
          meals.add(meal);
        }
      }
      result.add(Date(date: date['date'] as String, meals: meals));
    }

    return result;
  }

  @override
  Future<void> addMeal(Meal meal) async {
    database!.insert('Meals', meal.toJson());
  }

  @override
  Future<void> updateMeal(Meal meal) async {
    database!
        .update('Meals', meal.toJson(), where: 'id = ?', whereArgs: [meal.id]);
  }
}
