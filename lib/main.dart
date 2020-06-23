import 'package:flutter/material.dart';
import 'package:flutter_states_rebuilder_tutorial/pages/weather_search_page.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Material App',
      home: WeatherSearchPage(),
    );
  }
}
