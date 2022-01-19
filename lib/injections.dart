import 'package:calorie_calculator/data/datasources/local_data_source.dart';
import 'package:calorie_calculator/data/datasources/remote_data_source.dart';
import 'package:calorie_calculator/data/repositories/dates_repository.dart';
import 'package:calorie_calculator/domain/repositories/dates_repository.dart';
import 'package:calorie_calculator/domain/usecases/dates_usecases.dart';
import 'package:calorie_calculator/presentation/bloc/dates_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => DatesBloc(sl()));
  sl.registerLazySingleton(() => DatesUsecases(sl()));
  sl.registerLazySingleton<DatesRepository>(
      () => DatesRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl());
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
}
