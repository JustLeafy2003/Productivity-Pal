import 'package:flutter/material.dart';
import '../../widgets/text_tool_widget.dart';

class ReverseTextScreen extends StatelessWidget {
  const ReverseTextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reverse Text'),
      ),
      body: ToolWidget(
        title: 'Reverse Text',
        toolFunction: (String inputText) {
          String reversedText = inputText.split('').reversed.join('');
          return reversedText;
        },
      ),
    );
  }
}
