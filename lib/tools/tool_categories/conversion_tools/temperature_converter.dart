import 'package:flutter/material.dart';
import '../../widgets/unit_conversion_tool_widget.dart';

class TemperatureConverterScreen extends StatelessWidget {
  const TemperatureConverterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
      ),
      body: SingleChildScrollView(
        child: TemperatureConverterWidget(),
      ),
    );
  }
}

class TemperatureConverterWidget extends StatelessWidget {
  final List<String> temperatureUnits = ['Celsius', 'Fahrenheit', 'Kelvin'];

  TemperatureConverterWidget({super.key});

  String convertTemperature(String input, String inputUnit, String outputUnit) {
    double inputValue = double.tryParse(input) ?? 0;
    double outputValue = 0;

    switch (inputUnit) {
      case 'Celsius':
        switch (outputUnit) {
          case 'Fahrenheit':
            outputValue = (inputValue * 9 / 5) + 32;
            break;
          case 'Kelvin':
            outputValue = inputValue + 273.15;
            break;
          default:
            outputValue = inputValue;
        }
        break;
      case 'Fahrenheit':
        switch (outputUnit) {
          case 'Celsius':
            outputValue = (inputValue - 32) * 5 / 9;
            break;
          case 'Kelvin':
            outputValue = (inputValue - 32) * 5 / 9 + 273.15;
            break;
          default:
            outputValue = inputValue;
        }
        break;
      case 'Kelvin':
        switch (outputUnit) {
          case 'Celsius':
            outputValue = inputValue - 273.15;
            break;
          case 'Fahrenheit':
            outputValue = (inputValue - 273.15) * 9 / 5 + 32;
            break;
          default:
            outputValue = inputValue;
        }
        break;
    }

    return outputValue.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return UnitConversionWidget(
      title: 'Temperature Converter',
      units: temperatureUnits,
      conversionFunction: convertTemperature,
    );
  }
}
