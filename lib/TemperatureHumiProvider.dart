import 'package:flutter/material.dart';

class TemperatureHumiModel {
  double temperature;
  double humidity;

  TemperatureHumiModel({required this.temperature, required this.humidity});
}

class TemperatureHumiProvider with ChangeNotifier {
  List<TemperatureHumiModel> settings = List.generate(
    4, // Assuming you have 4 settings
    (index) => TemperatureHumiModel(temperature: 0.0, humidity: 0.0),
  ); // Initialize with default values.

  void setTemperatureValue(int index, double value) {
    settings[index].temperature = value;
    notifyListeners();
  }

  void setHumidityValue(int index, double value) {
    settings[index].humidity = value;
    notifyListeners();
  }
}
