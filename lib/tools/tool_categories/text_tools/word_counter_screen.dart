import 'package:flutter/material.dart';
import '../../widgets/text_tool_widget.dart';

class WordCounterScreen extends StatelessWidget {
  const WordCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Counter'),
      ),
      body: ToolWidget(
        title: 'Word Counter',
        toolFunction: (String inputText) {
          int wordCount = inputText.trim().split(RegExp(r'\s+')).length;
          return 'Word Count: $wordCount';
        },
        copyOutput: false,
      ),
    );
  }
}
