part of 'dates_bloc.dart';

@immutable
abstract class DatesState {
  final List<Date> dates;

  DatesState({this.dates = const []});
}

class DatesInitial extends DatesState {
  DatesInitial() : super(dates: []);
}

class DatesLoadedState extends DatesState {
  final List<Date> dates;

  DatesLoadedState(this.dates) : super(dates: dates);
}

class DatePendingState extends DatesState {
  final List<Date> dates;

  DatePendingState(this.dates) : super(dates: dates);
}
