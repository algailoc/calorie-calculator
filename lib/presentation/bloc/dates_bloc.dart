import 'package:bloc/bloc.dart';
import 'package:calorie_calculator/domain/entities/date.dart';
import 'package:calorie_calculator/domain/entities/meal.dart';
import 'package:calorie_calculator/domain/usecases/dates_usecases.dart';
import 'package:calorie_calculator/main.dart';
import 'package:calorie_calculator/utils/date_converters.dart';
import 'package:meta/meta.dart';

part 'dates_event.dart';
part 'dates_state.dart';

class DatesBloc extends Bloc<DatesEvent, DatesState> {
  final DatesUsecases usecases;

  List<Date> dates = [];

  DatesBloc(this.usecases) : super(DatesInitial()) {
    on<DatesEvent>((event, emit) async {
      if (event is FetchDatesEvent) {
        emit(DatePendingState(dates));
        final result = await usecases.getDates();
        dates = result;
        dates.sort(
            (a, b) => stringToDate(b.date).compareTo(stringToDate(a.date)));
        emit(DatesLoadedState(dates));
      } else if (event is AddMealEvent) {
        emit(DatePendingState(dates));
        final meal = await usecases.addMeal(event.meal);
        int idx = dates.indexWhere((element) => element.date == meal.date);
        dates[idx].meals.add(meal);
        emit(DatesLoadedState(dates));
      } else if (event is UpdateMealEvent) {
        emit(DatePendingState(dates));
        final meal = await usecases.updateMeal(event.meal);
        int idx = dates.indexWhere((element) => element.date == meal.date);
        int newMealIdx = dates[idx].meals.indexWhere((el) => el.id == meal.id);
        dates[idx].meals[newMealIdx] = meal;
        emit(DatesLoadedState(dates));
      } else if (event is DeleteMealEvent) {
        emit(DatePendingState(dates));
        await usecases.deleteMeal(event.meal);
        int idx =
            dates.indexWhere((element) => element.date == event.meal.date);
        List<Meal> newMeals = dates[idx]
            .meals
            .where((element) => element.id != event.meal.id)
            .toList();
        dates[idx] = dates[idx].copyWith(meals: newMeals);
        emit(DatesLoadedState(dates));
      } else if (event is AddDateEvent) {
        emit(DatePendingState(dates));
        var oldDates = await database!.query(
          'Dates',
          where: 'date = ?',
          whereArgs: [event.date],
        );
        if (oldDates.isEmpty) {
          await usecases.addDate(event.date);
          dates.add(Date(date: event.date, meals: []));
          dates.sort(
              (a, b) => stringToDate(b.date).compareTo(stringToDate(a.date)));
          emit(DatesLoadedState(dates));
        } else {
          emit(DateFailureState(dates, 'Date already exists'));
        }
      }
    });
  }
}
