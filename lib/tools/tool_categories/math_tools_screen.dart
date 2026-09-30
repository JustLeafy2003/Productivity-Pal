import 'package:flutter/material.dart';
import 'math_tools/algebra_tools.dart';
import 'math_tools/geometry_tools.dart';
import 'math_tools/statistics_tools.dart';
import 'math_tools/trigonometry_tools.dart';

class MathToolsScreen extends StatelessWidget {
  const MathToolsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Tools'),
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
                          builder: (context) => const GeometryToolsScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.category),
                    label: const Text(
                      'Geometry Tools',
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
                          builder: (context) => const AlgebraToolsScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.plus_one),
                    label: const Text(
                      'Algebra Tools',
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
                          builder: (context) => const TrigonometryTools(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.square_foot),
                    label: const Text(
                      'Trigonometry Tools',
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
                          builder: (context) => const StatisticsTools(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.leaderboard),
                    label: const Text(
                      'Statistics Calculator',
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
