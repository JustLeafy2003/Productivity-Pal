import 'package:flutter/material.dart';
import '../../widgets/unit_conversion_tool_widget.dart';

class TimeConverterScreen extends StatelessWidget {
  const TimeConverterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Converter'),
      ),
      body: SingleChildScrollView(
        child: TimeConverterWidget(),
      ),
    );
  }
}

class TimeConverterWidget extends StatelessWidget {
  final List<String> timeUnits = [
    'Seconds',
    'Minutes',
    'Hours',
    'Days',
    'Weeks',
    'Months',
    'Years'
  ];

  final Map<String, Map<String, double>> conversionTable = {
    'Seconds': {
      'Seconds': 1,
      'Minutes': 1 / 60,
      'Hours': 1 / 3600,
      'Days': 1 / 86400,
      'Weeks': 1 / 604800,
      'Months': 1 / 2629800,
      'Years': 1 / 31557600,
    },
    'Minutes': {
      'Seconds': 60,
      'Minutes': 1,
      'Hours': 1 / 60,
      'Days': 1 / 1440,
      'Weeks': 1 / 10080,
      'Months': 1 / 43800,
      'Years': 1 / 525600,
    },
    'Hours': {
      'Seconds': 3600,
      'Minutes': 60,
      'Hours': 1,
      'Days': 1 / 24,
      'Weeks': 1 / 168,
      'Months': 1 / 730,
      'Years': 1 / 8760,
    },
    'Days': {
      'Seconds': 86400,
      'Minutes': 1440,
      'Hours': 24,
      'Days': 1,
      'Weeks': 1 / 7,
      'Months': 1 / 30.44,
      'Years': 1 / 365,
    },
    'Weeks': {
      'Seconds': 604800,
      'Minutes': 10080,
      'Hours': 168,
      'Days': 7,
      'Weeks': 1,
      'Months': 1 / 4.345,
      'Years': 1 / 52.143,
    },
    'Months': {
      'Seconds': 2629800,
      'Minutes': 43800,
      'Hours': 730,
      'Days': 30.44,
      'Weeks': 4.345,
      'Months': 1,
      'Years': 1 / 12,
    },
    'Years': {
      'Seconds': 31557600,
      'Minutes': 525600,
      'Hours': 8760,
      'Days': 365,
      'Weeks': 52.143,
      'Months': 12,
      'Years': 1,
    },
  };

  TimeConverterWidget({super.key});

  String convertTime(String input, String inputUnit, String outputUnit) {
    double inputValue = double.tryParse(input) ?? 0;
    double outputValue = inputValue * conversionTable[inputUnit]![outputUnit]!;
    return outputValue.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return UnitConversionWidget(
      title: 'Time Converter',
      units: timeUnits,
      conversionFunction: convertTime,
    );
  }
}
