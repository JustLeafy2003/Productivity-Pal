import 'package:flutter/material.dart';
import '../../widgets/unit_conversion_tool_widget.dart';

class WeightConverterScreen extends StatelessWidget {
  const WeightConverterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight Converter'),
      ),
      body: SingleChildScrollView(
        child: WeightConverterWidget(),
      ),
    );
  }
}

class WeightConverterWidget extends StatelessWidget {
  final List<String> weightUnits = [
    'Kilograms',
    'Grams',
    'Milligrams',
    'Pounds',
    'Ounces',
    'Tons'
  ];

  final Map<String, Map<String, double>> conversionTable = {
    'Kilograms': {
      'Kilograms': 1,
      'Grams': 1000,
      'Milligrams': 1e6,
      'Pounds': 2.20462,
      'Ounces': 35.274,
      'Tons': 0.001,
    },
    'Grams': {
      'Kilograms': 0.001,
      'Grams': 1,
      'Milligrams': 1000,
      'Pounds': 0.00220462,
      'Ounces': 0.035274,
      'Tons': 1e-6,
    },
    'Milligrams': {
      'Kilograms': 1e-6,
      'Grams': 0.001,
      'Milligrams': 1,
      'Pounds': 2.2046e-6,
      'Ounces': 3.5274e-5,
      'Tons': 1e-9,
    },
    'Pounds': {
      'Kilograms': 0.453592,
      'Grams': 453.592,
      'Milligrams': 453592,
      'Pounds': 1,
      'Ounces': 16,
      'Tons': 0.000453592,
    },
    'Ounces': {
      'Kilograms': 0.0283495,
      'Grams': 28.3495,
      'Milligrams': 28349.5,
      'Pounds': 0.0625,
      'Ounces': 1,
      'Tons': 2.835e-5,
    },
    'Tons': {
      'Kilograms': 1000,
      'Grams': 1e6,
      'Milligrams': 1e9,
      'Pounds': 2204.62,
      'Ounces': 35274,
      'Tons': 1,
    },
  };

  WeightConverterWidget({super.key});

  String convertWeight(String input, String inputUnit, String outputUnit) {
    double inputValue = double.tryParse(input) ?? 0;
    double outputValue = inputValue * conversionTable[inputUnit]![outputUnit]!;
    return outputValue.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return UnitConversionWidget(
      title: 'Weight Converter',
      units: weightUnits,
      conversionFunction: convertWeight,
    );
  }
}
