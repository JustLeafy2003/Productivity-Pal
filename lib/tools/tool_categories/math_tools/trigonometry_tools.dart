import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrigonometryTools extends StatelessWidget {
  const TrigonometryTools({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trigonometry Tools'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Pythagorean Theorem: a^2+b^2=c^2',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              // Add margin and copy output button
              const PythagoreanTheoremWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class PythagoreanTheoremWidget extends StatefulWidget {
  const PythagoreanTheoremWidget({Key? key}) : super(key: key);

  @override
  _PythagoreanTheoremWidgetState createState() =>
      _PythagoreanTheoremWidgetState();
}

class _PythagoreanTheoremWidgetState extends State<PythagoreanTheoremWidget> {
  late TextEditingController _controllerA;
  late TextEditingController _controllerB;
  String _output = '';

  @override
  void initState() {
    super.initState();
    _controllerA = TextEditingController();
    _controllerB = TextEditingController();
  }

  @override
  void dispose() {
    _controllerA.dispose();
    _controllerB.dispose();
    super.dispose();
  }

  void _calculateHypotenuse() {
    final sideA = double.tryParse(_controllerA.text) ?? 0;
    final sideB = double.tryParse(_controllerB.text) ?? 0;

    final hypotenuse = sqrt(sideA * sideA + sideB * sideB);
    setState(() {
      _output = 'Hypotenuse: $hypotenuse';
    });
  }

  void _copyOutput() {
    Clipboard.setData(ClipboardData(text: _output));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Output copied to clipboard'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final paddingValue = max(16.0, screenWidth * 0.1);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingValue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _controllerA,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Length of Side A',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _controllerB,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Length of Side B',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _calculateHypotenuse,
            child: const Text('Calculate Hypotenuse'),
          ),
          const SizedBox(height: 16.0),
          Text(
            _output,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _copyOutput,
            child: const Text('Copy Output'),
          ),
        ],
      ),
    );
  }
}
