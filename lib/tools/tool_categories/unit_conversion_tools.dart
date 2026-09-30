import 'package:flutter/material.dart';
import 'conversion_tools/currency_converter.dart';
import 'conversion_tools/length_converter.dart';
import 'conversion_tools/speed_converter.dart';
import 'conversion_tools/temperature_converter.dart';
import 'conversion_tools/time_converter.dart';
import 'conversion_tools/weight_converter.dart';

class UnitConversionToolsScreen extends StatelessWidget {
  const UnitConversionToolsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Conversion Tools'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const CurrencyConverterScreen()),
                      );
                    },
                    icon: const Icon(Icons.euro),
                    label: const Text(
                      'Currency Converter',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color.fromARGB(255, 240, 237, 240)
                              : const Color.fromARGB(255, 42, 40, 47),
                    ),
                  ),
                  const SizedBox(
                      height: 16), // Add vertical spacing between buttons
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const LengthConverterScreen()),
                      );
                    },
                    icon: const Icon(Icons.linear_scale),
                    label: const Text(
                      'Length Converter',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color.fromARGB(255, 240, 237, 240)
                              : const Color.fromARGB(255, 42, 40, 47),
                    ),
                  ),
                  const SizedBox(
                      height: 16), // Add vertical spacing between buttons
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SpeedConverterScreen()),
                      );
                    },
                    icon: const Icon(Icons.speed),
                    label: const Text(
                      'Speed Converter',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color.fromARGB(255, 240, 237, 240)
                              : const Color.fromARGB(255, 42, 40, 47),
                    ),
                  ),
                  const SizedBox(
                      height: 16), // Add vertical spacing between buttons
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const TemperatureConverterScreen()),
                      );
                    },
                    icon: const Icon(Icons.thermostat),
                    label: const Text(
                      'Temperature Converter',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color.fromARGB(255, 240, 237, 240)
                              : const Color.fromARGB(255, 42, 40, 47),
                    ),
                  ),
                  const SizedBox(
                      height: 16), // Add vertical spacing between buttons
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TimeConverterScreen()),
                      );
                    },
                    icon: const Icon(Icons.timer),
                    label: const Text(
                      'Time Converter',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color.fromARGB(255, 240, 237, 240)
                              : const Color.fromARGB(255, 42, 40, 47),
                    ),
                  ),
                  const SizedBox(
                      height: 16), // Add vertical spacing between buttons
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const WeightConverterScreen()),
                      );
                    },
                    icon: const Icon(Icons.monitor_weight),
                    label: const Text(
                      'Weight Converter',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color.fromARGB(255, 240, 237, 240)
                              : const Color.fromARGB(255, 42, 40, 47),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
