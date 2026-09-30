import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormulaWidget extends StatefulWidget {
  final String formulaName;
  final String variable;
  final double Function(double) conversionFunction;

  const FormulaWidget({
    required this.formulaName,
    required this.variable,
    required this.conversionFunction,
    Key? key,
  }) : super(key: key);

  @override
  _FormulaWidgetState createState() => _FormulaWidgetState();
}

class _FormulaWidgetState extends State<FormulaWidget> {
  late final TextEditingController _controller = TextEditingController();
  String _output = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _executeConversion() {
    final inputValue = _controller.text;

    // Check if the input value is valid
    if (inputValue.isEmpty) {
      setState(() {
        _output = 'Error: Input value is empty';
      });
      return;
    }

    final value = double.tryParse(inputValue) ?? 0;
    final convertedValue = widget.conversionFunction(value);
    setState(() {
      _output = '$convertedValue';
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
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.formulaName,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: widget.variable,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _executeConversion,
            child: const Text('Execute'),
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
