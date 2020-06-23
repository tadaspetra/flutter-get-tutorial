import 'package:flutter_states_rebuilder_tutorial/data/model/weather.dart';
import 'package:flutter_states_rebuilder_tutorial/data/weather_repository.dart';
import 'package:get/get.dart';

class WeatherStore extends GetController {
  final WeatherRepository _weatherRepository;

  WeatherStore(this._weatherRepository);

  Weather _weather;
  Weather get weather => _weather;

  void getWeather(String cityName) async {
    try {
      _weather = await _weatherRepository.fetchWeather(cityName);
      update();
    } on NetworkError {
      Get.snackbar(
        "Network Error",
        "Experiencing connectivity issues",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print(e);
    }
  }
}
