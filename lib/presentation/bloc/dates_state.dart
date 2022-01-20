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
  DatesLoadedState(dates) : super(dates: dates);
}

class DatePendingState extends DatesState {
  DatePendingState(dates) : super(dates: dates);
}

class DateFailureState extends DatesState {
  // final List<Date> dates;
  final String message;

  DateFailureState(dates, this.message) : super(dates: dates);
}
