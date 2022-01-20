part of 'dates_bloc.dart';

@immutable
abstract class DatesEvent {}

class FetchDatesEvent extends DatesEvent {}

class AddMealEvent extends DatesEvent {
  final Meal meal;

  AddMealEvent(this.meal);
}

class UpdateMealEvent extends DatesEvent {
  final Meal meal;

  UpdateMealEvent(this.meal);
}

class DeleteMealEvent extends DatesEvent {
  final Meal meal;

  DeleteMealEvent(this.meal);
}

class AddDateEvent extends DatesEvent {
  final String date;

  AddDateEvent(this.date);
}
