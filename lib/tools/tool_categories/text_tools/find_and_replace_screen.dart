import 'package:flutter/material.dart';
import '../../widgets/text_tool_widget.dart';

class FindAndReplaceScreen extends StatelessWidget {
  const FindAndReplaceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find and Replace'),
      ),
      body: SingleChildScrollView(
        // Wrap body with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ToolWidget(
                title: 'Find and Replace',
                toolFunction: (String inputText) {
                  // Get the text to find and replace
                  String findText = _findController.text;
                  String replaceText = _replaceController.text;

                  // Perform find and replace
                  String outputText =
                      inputText.replaceAll(findText, replaceText);
                  return outputText;
                },
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _findController,
                decoration: const InputDecoration(
                  labelText: 'Find',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _replaceController,
                decoration: const InputDecoration(
                  labelText: 'Replace',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Controllers for the find and replace fields
final TextEditingController _findController = TextEditingController();
final TextEditingController _replaceController = TextEditingController();
