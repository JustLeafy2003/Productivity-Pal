import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class StatisticsTools extends StatelessWidget {
  const StatisticsTools({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics Calculator'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Statistics Calculator',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              // Add margin and copy output button
              const StatisticsCalculator(),
            ],
          ),
        ),
      ),
    );
  }
}

class StatisticsCalculator extends StatefulWidget {
  const StatisticsCalculator({Key? key}) : super(key: key);

  @override
  _StatisticsCalculatorState createState() => _StatisticsCalculatorState();
}

class _StatisticsCalculatorState extends State<StatisticsCalculator> {
  late TextEditingController _dataController;
  String _output = '';

  @override
  void initState() {
    super.initState();
    _dataController = TextEditingController();
  }

  @override
  void dispose() {
    _dataController.dispose();
    super.dispose();
  }

  void _calculateStatistics() {
    final List<double> data = _dataController.text.split(',').map((e) {
      final trimmed = e.trim();
      return double.tryParse(trimmed) ?? 0;
    }).toList();

    final mean = data.isEmpty ? 0 : data.reduce((a, b) => a + b) / data.length;

    final sortedData = [...data]..sort();
    final middleIndex = sortedData.length ~/ 2;
    final median = sortedData.length.isEven
        ? (sortedData[middleIndex - 1] + sortedData[middleIndex]) / 2
        : sortedData[middleIndex];

    final modeMap = <double, int>{};
    for (var element in data) {
      modeMap[element] = (modeMap[element] ?? 0) + 1;
    }
    final mode = modeMap.entries
        .where((entry) => entry.value == modeMap.values.reduce(max))
        .map((entry) => entry.key)
        .toList();

    final variance = data.isEmpty
        ? 0
        : data.map((e) => (e - mean) * (e - mean)).reduce((a, b) => a + b) /
            data.length;

    final standardDeviation = sqrt(variance);

    setState(() {
      _output = '''
Mean: $mean
Median: $median
Mode: ${mode.join(', ')}
Variance: $variance
Standard Deviation: $standardDeviation
      ''';
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
            controller: _dataController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Enter data separated by commas',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _calculateStatistics,
            child: const Text('Calculate Statistics'),
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
