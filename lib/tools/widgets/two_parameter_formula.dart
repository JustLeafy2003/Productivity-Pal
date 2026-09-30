import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TwoParameterFormulaWidget extends StatefulWidget {
  final String formulaName;
  final String variable1;
  final String variable2;
  final double Function(double, double) conversionFunction;

  const TwoParameterFormulaWidget({
    required this.formulaName,
    required this.variable1,
    required this.variable2,
    required this.conversionFunction,
    Key? key,
  }) : super(key: key);

  @override
  _TwoParameterFormulaWidgetState createState() =>
      _TwoParameterFormulaWidgetState();
}

class _TwoParameterFormulaWidgetState extends State<TwoParameterFormulaWidget> {
  late TextEditingController _controller1;
  late TextEditingController _controller2;
  String _output = '';

  @override
  void initState() {
    super.initState();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  void _executeConversion() {
    final double value1 = double.tryParse(_controller1.text) ?? 0;
    final double value2 = double.tryParse(_controller2.text) ?? 0;
    final double result = widget.conversionFunction(value1, value2);
    setState(() {
      _output = '$result';
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
          TextField(
            controller: _controller1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: widget.variable1,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _controller2,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: widget.variable2,
              border: const OutlineInputBorder(),
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
