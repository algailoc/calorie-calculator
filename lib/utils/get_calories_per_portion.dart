import 'package:dio/dio.dart';

Future<double> getCaloriesPerPortion(String portion, String name) async {
  Dio dio = Dio();
  final response = await dio
      .post('https://trackapi.nutritionix.com/v2/natural/nutrients',
          data: {"query": '$portion $name'},
          options: Options(
            headers: {
              'x-app-id': 'db9377fc',
              'x-app-key': '1f9b53f1d93be0895ab150882ba9e802',
              'x-remote-user-id': 0,
            },
          ))
      .onError((error, stackTrace) {
    String message = error is! DioError ? 'Ошибка сервера' : error.message;

    throw Exception(message);
  });

  double result = 0.0;
  if ((response.data['foods'] as List).isNotEmpty) {
    result = response.data['foods'][0]['nf_calories'] is int
        ? (response.data['foods'][0]['nf_calories']).toDouble()
        : response.data['foods'][0]['nf_calories'];
  }

  return result;
}
