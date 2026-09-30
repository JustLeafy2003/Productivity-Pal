import 'dart:math';
import 'package:flutter/material.dart';
import '../../widgets/one_parameter_formula.dart';
import '../../widgets/two_parameter_formula.dart';

class GeometryToolsScreen extends StatelessWidget {
  const GeometryToolsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final paddingValue =
        max(16.0, screenWidth * 0.1); // Ensure minimum padding of 16.0

    return Scaffold(
      appBar: AppBar(
        title: const Text('Geometry Tools'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Areas
            _buildSectionHeading('Areas'),
            SizedBox(
              width: screenWidth * 0.5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingValue),
                child: TwoParameterFormulaWidget(
                  formulaName: 'Area of a Rectangle (Length * Width)',
                  variable1: 'Length',
                  variable2: 'Width',
                  conversionFunction: (length, width) => length * width,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: screenWidth * 0.5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingValue),
                child: TwoParameterFormulaWidget(
                  formulaName: 'Area of a Triangle (1/2 * Base * Height)',
                  variable1: 'Base',
                  variable2: 'Height',
                  conversionFunction: (base, height) => 0.5 * base * height,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: screenWidth * 0.5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingValue),
                child: FormulaWidget(
                  formulaName: 'Area of a Circle (π * Radius^2)',
                  variable: 'Radius',
                  conversionFunction: (radius) => pi * radius * radius,
                ),
              ),
            ),
            const SizedBox(height: 32.0), // Add spacing between sections

            // Perimeters
            _buildSectionHeading('Perimeters'),
            SizedBox(
              width: screenWidth * 0.5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingValue),
                child: FormulaWidget(
                  formulaName: 'Perimeter of a Square (4 * Side)',
                  variable: 'Side Length',
                  conversionFunction: (side) => 4 * side,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: screenWidth * 0.5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingValue),
                child: TwoParameterFormulaWidget(
                  formulaName:
                      'Perimeter of a Rectangle (2 * (Length + Width))',
                  variable1: 'Length',
                  variable2: 'Width',
                  conversionFunction: (length, width) => 2 * (length + width),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: screenWidth * 0.5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingValue),
                child: FormulaWidget(
                  formulaName: 'Perimeter of a Circle (2 * π * Radius)',
                  variable: 'Radius',
                  conversionFunction: (radius) => 2 * pi * radius,
                ),
              ),
            ),
            const SizedBox(height: 32.0), // Add spacing between sections

            // Volumes
            _buildSectionHeading('Volumes'),
            SizedBox(
              width: screenWidth * 0.5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingValue),
                child: FormulaWidget(
                  formulaName: 'Volume of a Cube (Side^3)',
                  variable: 'Side Length',
                  conversionFunction: (side) => pow(side, 3).toDouble(),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: screenWidth * 0.5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingValue),
                child: TwoParameterFormulaWidget(
                  formulaName: 'Volume of a Cylinder (π * Radius^2 * Height)',
                  variable1: 'Radius',
                  variable2: 'Height',
                  conversionFunction: (radius, height) =>
                      pi * radius * radius * height,
                ),
              ),
            ),
            const SizedBox(height: 32.0), // Add spacing between sections

            // Surface Areas
            _buildSectionHeading('Surface Areas'),
            SizedBox(
              width: screenWidth * 0.5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingValue),
                child: FormulaWidget(
                  formulaName: 'Surface Area of a Sphere (4 * π * Radius^2)',
                  variable: 'Radius',
                  conversionFunction: (radius) => 4 * pi * radius * radius,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeading(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
