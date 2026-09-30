import 'dart:math';
import 'package:flutter/material.dart';
import '../../widgets/three_parameter_formula.dart';
import '../../widgets/four_parameter_formula.dart';

class AlgebraToolsScreen extends StatelessWidget {
  const AlgebraToolsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final paddingValue =
        max(16.0, screenWidth * 0.1); // Ensure minimum padding of 16.0

    return Scaffold(
      appBar: AppBar(
        title: const Text('Algebra Tools'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Slope of a line
            SizedBox(
              width: screenWidth * 0.5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingValue),
                child: FourParameterFormulaWidget(
                  formulaName: 'Slope of a Line: (y2-y1)/(x2-x1)',
                  variable1: 'x1',
                  variable2: 'y1',
                  variable3: 'x2',
                  variable4: 'y2',
                  conversionFunction: (x1, y1, x2, y2) => [
                    (double.parse(y2) - double.parse(y1)) /
                        (double.parse(x2) - double.parse(x1))
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32.0), // Add spacing between sections

            // Distance between two points in a plane
            SizedBox(
              width: screenWidth * 0.5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingValue),
                child: FourParameterFormulaWidget(
                  formulaName:
                      'Distance between Two Points: √((x2-x1)^2+y2-y1)^2)',
                  variable1: 'x1',
                  variable2: 'y1',
                  variable3: 'x2',
                  variable4: 'y2',
                  conversionFunction: (x1, y1, x2, y2) => [
                    sqrt(pow(double.parse(x2) - double.parse(x1), 2) +
                        pow(double.parse(y2) - double.parse(y1), 2))
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32.0), // Add spacing between sections

            // Quadratic formula
            SizedBox(
              width: screenWidth * 0.5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingValue),
                child: ThreeParameterFormulaWidget(
                  formulaName:
                      'Quadratic Formula: x = (-b ± √(b² - 4ac)) / (2a)',
                  variable1: 'a',
                  variable2: 'b',
                  variable3: 'c',
                  conversionFunction: (a, b, c) {
                    final determinant = double.parse(b) * double.parse(b) -
                        4 * double.parse(a) * double.parse(c);
                    if (determinant < 0) {
                      return ['No real roots'];
                    } else {
                      final root1 = (-double.parse(b) + pow(determinant, 0.5)) /
                          (2 * double.parse(a));
                      final root2 = (-double.parse(b) - pow(determinant, 0.5)) /
                          (2 * double.parse(a));
                      return ['Root 1: $root1', 'Root 2: $root2'];
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 32.0), // Add spacing between sections
          ],
        ),
      ),
    );
  }
}
