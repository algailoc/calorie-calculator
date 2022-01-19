import 'package:calorie_calculator/presentation/bloc/dates_bloc.dart';
import 'package:calorie_calculator/presentation/screens/home/home_page.dart';
import 'package:calorie_calculator/utils/date_converters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'injections.dart' as di;

Database? database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  database = await openDatabase('my_db.db', version: 1,
      onCreate: (Database db, int version) async {
    await db.execute('CREATE TABLE Dates (date STRING)');
    await db.execute(
        'CREATE TABLE Meals (date STRING , id STRING, name STRING, calories REAL, weight REAL, portion STRING)');
  });

  var dates = await database!.query(
    'Dates',
    where: 'date = ?',
    whereArgs: [
      dateToString(DateTime.now().toLocal()),
    ],
  );

  if (dates.isEmpty) {
    database!.insert('Dates', {
      'date': dateToString(DateTime.now().toLocal()),
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<DatesBloc>(),
      child: MaterialApp(
        title: 'Calories calculator',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
