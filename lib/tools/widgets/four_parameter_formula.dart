import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FourParameterFormulaWidget extends StatefulWidget {
  final String formulaName;
  final String variable1;
  final String variable2;
  final String variable3;
  final String variable4;
  final List<dynamic> Function(String, String, String, String)
      conversionFunction;

  const FourParameterFormulaWidget({
    required this.formulaName,
    required this.variable1,
    required this.variable2,
    required this.variable3,
    required this.variable4,
    required this.conversionFunction,
    Key? key,
  }) : super(key: key);

  @override
  _FourParameterFormulaWidgetState createState() =>
      _FourParameterFormulaWidgetState();
}

class _FourParameterFormulaWidgetState
    extends State<FourParameterFormulaWidget> {
  late TextEditingController _controller1;
  late TextEditingController _controller2;
  late TextEditingController _controller3;
  late TextEditingController _controller4;
  List<dynamic> _outputs = [];

  @override
  void initState() {
    super.initState();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    _controller4 = TextEditingController();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  void _executeConversion() {
    final value1 = _controller1.text;
    final value2 = _controller2.text;
    final value3 = _controller3.text;
    final value4 = _controller4.text;

    final outputs = widget.conversionFunction(value1, value2, value3, value4);
    setState(() {
      _outputs = outputs;
    });
  }

  void _copyOutput() {
    final String outputText = _outputs.join('\n');
    Clipboard.setData(ClipboardData(text: outputText));
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
          TextField(
            controller: _controller3,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: widget.variable3,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _controller4,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: widget.variable4,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _executeConversion,
            child: const Text('Execute'),
          ),
          const SizedBox(height: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _outputs
                .map((output) => Text(
                      output.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16.0),
                    ))
                .toList(),
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
