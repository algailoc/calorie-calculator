import 'package:calorie_calculator/domain/entities/date.dart';
import 'package:calorie_calculator/domain/entities/meal.dart';
import 'package:calorie_calculator/main.dart';
import 'package:uuid/uuid.dart';

abstract class LocalDataSource {
  Future<List<Date>> getDates();
  Future<Meal> addMeal(Meal meal);
  Future<Meal> updateMeal(Meal meal);
  Future<String> deleteMeal(Meal meal);
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

    return result.reversed.toList();
  }

  @override
  Future<Meal> addMeal(Meal meal) async {
    var uuid = const Uuid();

    database!.insert('Meals', meal.toJson());
    return Meal(
        id: uuid.v4(),
        date: meal.date,
        name: meal.name,
        calories: meal.calories,
        weight: meal.weight,
        portion: meal.portion);
  }

  @override
  Future<Meal> updateMeal(Meal meal) async {
    database!
        .update('Meals', meal.toJson(), where: 'id = ?', whereArgs: [meal.id]);

    return meal;
  }

  @override
  Future<String> deleteMeal(Meal meal) async {
    database!.delete('Meals', where: 'id = ?', whereArgs: [meal.id]);
    return meal.id;
  }
}
