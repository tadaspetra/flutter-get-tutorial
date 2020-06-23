import 'package:flutter/material.dart';
import 'package:flutter_states_rebuilder_tutorial/data/model/weather.dart';
import 'package:flutter_states_rebuilder_tutorial/data/weather_repository.dart';
import 'package:flutter_states_rebuilder_tutorial/state/weather_store.dart';
import 'package:get/get.dart';

class WeatherSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Search"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: GetBuilder<WeatherStore>(
          init: WeatherStore(FakeWeatherRepository()),
          builder: (currentWeather) {
            if (currentWeather.weather == null) {
              return buildInitialInput();
            } else {
              return buildColumnWithData(currentWeather.weather);
            }
          },
          tag: "onlyWeather",
        ),
      ),
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: CityInputField(),
    );
  }

  Column buildColumnWithData(Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.cityName,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          // Display the temperature with 1 decimal place
          "${weather.temperatureCelsius.toStringAsFixed(1)} °C",
          style: TextStyle(fontSize: 80),
        ),
        CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitCityName(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a city",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCityName(BuildContext context, String cityName) {
    WeatherStore weatherStore = Get.find(tag: "onlyWeather");

    weatherStore.getWeather(cityName);
  }
}
