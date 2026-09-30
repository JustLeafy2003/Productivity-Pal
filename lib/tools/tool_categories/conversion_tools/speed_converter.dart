import 'package:flutter/material.dart';
import '../../widgets/unit_conversion_tool_widget.dart';

class SpeedConverterScreen extends StatelessWidget {
  const SpeedConverterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speed Converter'),
      ),
      body: SingleChildScrollView(
        child: SpeedConverterWidget(),
      ),
    );
  }
}

class SpeedConverterWidget extends StatelessWidget {
  final List<String> speedUnits = [
    'Meters per second',
    'Miles per hour',
    'Kilometers per hour',
    'Nautical miles per hour'
  ];

  final Map<String, Map<String, double>> conversionTable = {
    'Meters per second': {
      'Meters per second': 1,
      'Miles per hour': 2.23694,
      'Kilometers per hour': 3.6,
      'Nautical miles per hour': 1.94384,
    },
    'Miles per hour': {
      'Meters per second': 0.44704,
      'Miles per hour': 1,
      'Kilometers per hour': 1.60934,
      'Nautical miles per hour': 0.868976,
    },
    'Kilometers per hour': {
      'Meters per second': 0.277778,
      'Miles per hour': 0.621371,
      'Kilometers per hour': 1,
      'Nautical miles per hour': 0.539957,
    },
    'Nautical miles per hour': {
      'Meters per second': 0.514444,
      'Miles per hour': 1.15078,
      'Kilometers per hour': 1.852,
      'Nautical miles per hour': 1,
    },
  };

  SpeedConverterWidget({super.key});

  String convertSpeed(String input, String inputUnit, String outputUnit) {
    double inputValue = double.tryParse(input) ?? 0;
    double outputValue = inputValue * conversionTable[inputUnit]![outputUnit]!;
    return outputValue.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return UnitConversionWidget(
      title: 'Speed Converter',
      units: speedUnits,
      conversionFunction: convertSpeed,
    );
  }
}
