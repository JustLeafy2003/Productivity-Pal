import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ToolWidget extends StatelessWidget {
  final String title;
  final String Function(String) toolFunction;
  final bool copyOutput;
  final List<Widget> additionalFields;

  const ToolWidget({
    required this.title,
    required this.toolFunction,
    this.copyOutput = true,
    this.additionalFields = const [],
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _inputController = TextEditingController();
    TextEditingController _outputController = TextEditingController();

    void _executeTool() {
      String inputText = _inputController.text;
      String outputText = toolFunction(inputText);
      _outputController.text = outputText;
    }

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _inputController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Input',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            if (additionalFields.isNotEmpty) ...additionalFields,
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _executeTool,
              child: const Text('Execute'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _outputController,
              maxLines: 5,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Output',
                border: OutlineInputBorder(),
              ),
            ),
            if (copyOutput) ...[
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Clipboard.setData(
                      ClipboardData(text: _outputController.text));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Output copied to clipboard'),
                  ));
                },
                child: const Text('Copy Output'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
