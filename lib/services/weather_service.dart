import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  final Dio dio;

  final String baseUrl ='http://api.weatherapi.com/v1';
  final String apikey ='1fc4db1260d5466f904115455232410';

  WeatherService(this.dio);
  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
     try {
       Response response = await dio.get('$baseUrl/forecast.json?key=$apikey&q=$cityName&days=1');
       WeatherModel weatherModel = WeatherModel.fromJson(response.data);
       return weatherModel;
     } on DioException catch (e) {
       final String errorMessage = e.response?.data['error']['message'] ?? 'oops there was an error, try later';
       throw Exception(errorMessage);
     } catch(e){
       log(e.toString());
       throw Exception('oops there was an error, try later');
     }

  }


}