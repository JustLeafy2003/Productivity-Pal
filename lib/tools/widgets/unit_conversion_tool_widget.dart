import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UnitConversionWidget extends StatefulWidget {
  final String title;
  final List<String> units;
  final String Function(String, String, String) conversionFunction;

  const UnitConversionWidget({
    required this.title,
    required this.units,
    required this.conversionFunction,
    Key? key,
  }) : super(key: key);

  @override
  _UnitConversionWidgetState createState() => _UnitConversionWidgetState();
}

class _UnitConversionWidgetState extends State<UnitConversionWidget> {
  late String selectedInputUnit;
  late String selectedOutputUnit;
  late TextEditingController _inputController;
  late TextEditingController _outputController;

  @override
  void initState() {
    super.initState();
    selectedInputUnit = widget.units.first;
    selectedOutputUnit =
        widget.units.length > 1 ? widget.units[1] : widget.units.first;
    _inputController = TextEditingController();
    _outputController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    void _executeConversion() {
      String inputText = _inputController.text;
      String outputText = widget.conversionFunction(
          inputText, selectedInputUnit, selectedOutputUnit);
      _outputController.text = outputText;
    }

    void _copyOutput() {
      String outputText = _outputController.text +
          ' ' +
          selectedOutputUnit; // Concatenate output with output unit
      Clipboard.setData(ClipboardData(text: outputText));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Output copied to clipboard'),
      ));
    }

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedInputUnit,
                    items: widget.units
                        .map((unit) => DropdownMenuItem(
                              child: Text(unit),
                              value: unit,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedInputUnit = value!;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Input Unit',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedOutputUnit,
                    items: widget.units
                        .map((unit) => DropdownMenuItem(
                              child: Text(unit),
                              value: unit,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedOutputUnit = value!;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Output Unit',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _inputController,
              maxLines: 1,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Input Value',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _executeConversion,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _outputController,
              maxLines: 1,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Output Value',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _copyOutput, // Call the _copyOutput function
              child: const Text('Copy Output'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }
}
