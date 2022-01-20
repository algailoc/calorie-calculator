class Meal {
  final String id;
  final String date;
  final String name;
  final double calories;
  final double weight;
  final String portion;

  Meal(
      {required this.id,
      required this.date,
      required this.name,
      required this.calories,
      required this.weight,
      required this.portion});

  Meal copyWith(
      {double? calories, double? weight, String? portion, String? name}) {
    return Meal(
        id: id,
        date: date,
        name: name ?? this.name,
        calories: calories ?? this.calories,
        weight: weight ?? this.weight,
        portion: portion ?? this.portion);
  }

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
        id: json['id'],
        name: json['name'],
        date: json['date'],
        calories: json['calories'],
        weight: json['weight'],
        portion: json['portion'].toString());
  }

  @override
  String toString() {
    return '{id: $id, name: $name, date: $date, calories: $calories, weight: $weight, portion: $portion}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'name': name,
      'calories': calories,
      'weight': weight,
      'portion': portion,
    };
  }
}
