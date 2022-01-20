import 'package:calorie_calculator/domain/entities/date.dart';
import 'package:calorie_calculator/domain/entities/meal.dart';
import 'package:calorie_calculator/domain/repositories/dates_repository.dart';

class DatesUsecases {
  final DatesRepository repository;

  DatesUsecases(this.repository);

  Future<List<Date>> getDates() async {
    return await repository.getDates();
  }

  Future<Meal> addMeal(Meal meal) async {
    return await repository.addMeal(meal);
  }

  Future<Meal> updateMeal(Meal meal) async {
    return await repository.updateMeal(meal);
  }

  Future<String> deleteMeal(Meal meal) async {
    return await repository.deleteMeal(meal);
  }

  Future<String> addDate(String date) async {
    return await repository.addDate(date);
  }
}
