import 'package:calorie_calculator/domain/entities/date.dart';
import 'package:calorie_calculator/domain/entities/meal.dart';

abstract class DatesRepository {
  Future<List<Date>> getDates();
  Future<Meal> addMeal(Meal meal);
  Future<Meal> updateMeal(Meal meal);
  Future<String> deleteMeal(Meal meal);
}
