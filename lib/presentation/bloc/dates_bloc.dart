import 'package:bloc/bloc.dart';
import 'package:calorie_calculator/domain/entities/date.dart';
import 'package:calorie_calculator/domain/entities/meal.dart';
import 'package:calorie_calculator/domain/usecases/dates_usecases.dart';
import 'package:meta/meta.dart';

part 'dates_event.dart';
part 'dates_state.dart';

class DatesBloc extends Bloc<DatesEvent, DatesState> {
  final DatesUsecases usecases;

  List<Date> dates = [];

  DatesBloc(this.usecases) : super(DatesInitial()) {
    on<DatesEvent>((event, emit) async {
      if (event is FetchDatesEvent) {
        final result = await usecases.getDates();
        dates = result;
        print('RESULT $result');
        emit(DatesLoadedState(dates));
      } else if (event is AddMealEvent) {
        final meal = await usecases.addMeal(event.meal);
        print('BEFORE: $dates');
        int idx = dates.indexWhere((element) => element.date == meal.date);
        dates[idx].meals.add(meal);
        print('AFTER: $dates');
        emit(DatesLoadedState(dates));
      } else if (event is UpdateMealEvent) {
        final meal = await usecases.updateMeal(event.meal);
        print('BEFORE: $dates');
        int idx = dates.indexWhere((element) => element.date == meal.date);
        int newMealIdx = dates[idx].meals.indexWhere((el) => el.id == meal.id);
        dates[idx].meals[newMealIdx] = meal;
        print('AFTER: $dates');
        emit(DatesLoadedState(dates));
      } else if (event is DeleteMealEvent) {
        final meal = await usecases.deleteMeal(event.meal);
        print('BEFORE: $dates');
        int idx =
            dates.indexWhere((element) => element.date == event.meal.date);
        List<Meal> newMeals = dates[idx].meals;
        newMeals =
            newMeals.where((element) => element.id != event.meal.id).toList();
        dates[idx] = dates[idx].copyWith(meals: newMeals);
        print('AFTER: $dates');
        emit(DatesLoadedState(dates));
      }
    });
  }
}
