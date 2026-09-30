import 'package:flutter/material.dart';
import '../../widgets/unit_conversion_tool_widget.dart';

class CurrencyConverterScreen extends StatelessWidget {
  const CurrencyConverterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: SingleChildScrollView(
        child: CurrencyConverterWidget(),
      ),
    );
  }
}

class CurrencyConverterWidget extends StatelessWidget {
  final List<String> currencyUnits = [
    'USD',
    'Canadian Dollar',
    'Euro',
    'Australian Dollar',
    'Yen',
    'Pesos',
    'Pounds',
    'Kuwaiti Dinar',
    'Rupees',
    'Chinese Yuan'
  ];

  final Map<String, Map<String, double>> conversionTable = {
    'USD': {
      'USD': 1,
      'Canadian Dollar': 1.21,
      'Euro': 0.82,
      'Australian Dollar': 1.29,
      'Yen': 108.91,
      'Pesos': 20.21,
      'Pounds': 0.72,
      'Kuwaiti Dinar': 0.3,
      'Rupees': 73.1,
      'Chinese Yuan': 6.45,
    },
    'Canadian Dollar': {
      'USD': 0.83,
      'Canadian Dollar': 1,
      'Euro': 0.68,
      'Australian Dollar': 1.06,
      'Yen': 89.61,
      'Pesos': 16.64,
      'Pounds': 0.59,
      'Kuwaiti Dinar': 0.25,
      'Rupees': 61.78,
      'Chinese Yuan': 5.46,
    },
    'Euro': {
      'USD': 1.22,
      'Canadian Dollar': 1.47,
      'Euro': 1,
      'Australian Dollar': 1.56,
      'Yen': 132.07,
      'Pesos': 24.53,
      'Pounds': 0.87,
      'Kuwaiti Dinar': 0.37,
      'Rupees': 92.15,
      'Chinese Yuan': 8.12,
    },
    'Australian Dollar': {
      'USD': 0.78,
      'Canadian Dollar': 0.94,
      'Euro': 0.64,
      'Australian Dollar': 1,
      'Yen': 84.59,
      'Pesos': 15.72,
      'Pounds': 0.56,
      'Kuwaiti Dinar': 0.24,
      'Rupees': 59.12,
      'Chinese Yuan': 5.21,
    },
    'Yen': {
      'USD': 0.0092,
      'Canadian Dollar': 0.011,
      'Euro': 0.0076,
      'Australian Dollar': 0.012,
      'Yen': 1,
      'Pesos': 0.19,
      'Pounds': 0.007,
      'Kuwaiti Dinar': 0.003,
      'Rupees': 0.71,
      'Chinese Yuan': 0.062,
    },
    'Pesos': {
      'USD': 0.049,
      'Canadian Dollar': 0.060,
      'Euro': 0.041,
      'Australian Dollar': 0.063,
      'Yen': 5.23,
      'Pesos': 1,
      'Pounds': 0.036,
      'Kuwaiti Dinar': 0.015,
      'Rupees': 3.74,
      'Chinese Yuan': 0.33,
    },
    'Pounds': {
      'USD': 1.38,
      'Canadian Dollar': 1.67,
      'Euro': 1.15,
      'Australian Dollar': 1.81,
      'Yen': 153.08,
      'Pesos': 27.51,
      'Pounds': 1,
      'Kuwaiti Dinar': 0.42,
      'Rupees': 105.94,
      'Chinese Yuan': 9.33,
    },
    'Kuwaiti Dinar': {
      'USD': 3.31,
      'Canadian Dollar': 3.98,
      'Euro': 2.71,
      'Australian Dollar': 4.22,
      'Yen': 357.07,
      'Pesos': 66.55,
      'Pounds': 2.38,
      'Kuwaiti Dinar': 1,
      'Rupees': 249.34,
      'Chinese Yuan': 21.96,
    },
    'LBP': {
      'USD': 0.0007,
      'Canadian Dollar': 0.0008,
      'Euro': 0.0005,
      'Australian Dollar': 0.0008,
      'Yen': 0.069,
      'Pesos': 0.013,
      'Pounds': 0.0005,
      'Kuwaiti Dinar': 0.0002,
      'Rupees': 0.049,
      'Chinese Yuan': 0.004,
    },
    'Rupees': {
      'USD': 0.014,
      'Canadian Dollar': 0.017,
      'Euro': 0.012,
      'Australian Dollar': 0.019,
      'Yen': 1.41,
      'Pesos': 0.27,
      'Pounds': 0.009,
      'Kuwaiti Dinar': 0.004,
      'Rupees': 1,
      'Chinese Yuan': 0.088,
    },
    'Chinese Yuan': {
      'USD': 0.16,
      'Canadian Dollar': 0.19,
      'Euro': 0.12,
      'Australian Dollar': 0.19,
      'Yen': 16.04,
      'Pesos': 3.01,
      'Pounds': 0.11,
      'Kuwaiti Dinar': 0.046,
      'Rupees': 11.35,
      'Chinese Yuan': 1,
    },
  };

  CurrencyConverterWidget({super.key});

  String convertCurrency(String input, String inputUnit, String outputUnit) {
    double inputValue = double.tryParse(input) ?? 0;
    double outputValue = inputValue * conversionTable[inputUnit]![outputUnit]!;
    return outputValue.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return UnitConversionWidget(
      title: 'Currency Converter',
      units: currencyUnits,
      conversionFunction: convertCurrency,
    );
  }
}
