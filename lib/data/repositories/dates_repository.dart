import 'package:calorie_calculator/data/datasources/local_data_source.dart';
import 'package:calorie_calculator/data/datasources/remote_data_source.dart';
import 'package:calorie_calculator/domain/entities/meal.dart';
import 'package:calorie_calculator/domain/entities/date.dart';
import 'package:calorie_calculator/domain/repositories/dates_repository.dart';

class DatesRepositoryImpl extends DatesRepository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;

  DatesRepositoryImpl(this.localDataSource, this.remoteDataSource);

  @override
  Future<Meal> addMeal(Meal meal) async {
    return await localDataSource.addMeal(meal);
  }

  @override
  Future<String> deleteMeal(Meal meal) async {
    return await localDataSource.deleteMeal(meal);
  }

  @override
  Future<List<Date>> getDates() async {
    return await localDataSource.getDates();
  }

  @override
  Future<Meal> updateMeal(Meal meal) async {
    return await localDataSource.updateMeal(meal);
  }

  @override
  Future<String> addDate(String date) async {
    return await localDataSource.addDate(date);
  }
}
