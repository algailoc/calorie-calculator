import 'package:calorie_calculator/domain/entities/meal.dart';

class Date {
  final String date;
  final List<Meal> meals;

  Date({required this.date, required this.meals});

  Date copyWith({List<Meal>? meals}) {
    return Date(date: this.date, meals: meals ?? this.meals);
  }

  factory Date.fromJson(dynamic json, List<Meal> meals) {
    return Date(date: json['date'], meals: meals);
  }

  @override
  String toString() {
    return '{date: $date, meals: $meals}';
  }
}
