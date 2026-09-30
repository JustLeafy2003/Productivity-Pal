import 'package:flutter/material.dart';
import '../../widgets/unit_conversion_tool_widget.dart';

class LengthConverterScreen extends StatelessWidget {
  const LengthConverterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Length Converter'),
      ),
      body: SingleChildScrollView(
        // Make the page scrollable
        child: LengthConverterWidget(),
      ),
    );
  }
}

class LengthConverterWidget extends StatelessWidget {
  final List<String> lengthUnits = [
    'Millimeters',
    'Centimeters',
    'Meters',
    'Kilometers',
    'Feet',
    'Inches',
    'Miles'
  ];

  final Map<String, Map<String, double>> conversionTable = {
    'Millimeters': {
      'Millimeters': 1,
      'Centimeters': 0.1,
      'Meters': 0.001,
      'Kilometers': 1e-6,
      'Feet': 0.00328084,
      'Inches': 0.0393701,
      'Miles': 6.2137e-7,
    },
    'Centimeters': {
      'Millimeters': 10,
      'Centimeters': 1,
      'Meters': 0.01,
      'Kilometers': 1e-5,
      'Feet': 0.0328084,
      'Inches': 0.393701,
      'Miles': 6.2137e-6,
    },
    'Meters': {
      'Millimeters': 1000,
      'Centimeters': 100,
      'Meters': 1,
      'Kilometers': 0.001,
      'Feet': 3.28084,
      'Inches': 39.3701,
      'Miles': 0.000621371,
    },
    'Kilometers': {
      'Millimeters': 1e6,
      'Centimeters': 1e5,
      'Meters': 1000,
      'Kilometers': 1,
      'Feet': 3280.84,
      'Inches': 39370.1,
      'Miles': 0.621371,
    },
    'Feet': {
      'Millimeters': 304.8,
      'Centimeters': 30.48,
      'Meters': 0.3048,
      'Kilometers': 0.0003048,
      'Feet': 1,
      'Inches': 12,
      'Miles': 0.000189394,
    },
    'Inches': {
      'Millimeters': 25.4,
      'Centimeters': 2.54,
      'Meters': 0.0254,
      'Kilometers': 2.54e-5,
      'Feet': 0.0833333,
      'Inches': 1,
      'Miles': 1.5783e-5,
    },
    'Miles': {
      'Millimeters': 1609340,
      'Centimeters': 160934,
      'Meters': 1609.34,
      'Kilometers': 1.60934,
      'Feet': 5280,
      'Inches': 63360,
      'Miles': 1,
    },
  };

  LengthConverterWidget({super.key});

  String convertLength(String input, String inputUnit, String outputUnit) {
    double inputValue = double.tryParse(input) ?? 0;
    double outputValue = inputValue * conversionTable[inputUnit]![outputUnit]!;
    return outputValue.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return UnitConversionWidget(
      title: 'Length Converter',
      units: lengthUnits,
      conversionFunction: convertLength,
    );
  }
}
