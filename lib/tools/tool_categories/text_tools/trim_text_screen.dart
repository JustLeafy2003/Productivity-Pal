import 'package:flutter/material.dart';
import '../../widgets/text_tool_widget.dart';

class TrimTextScreen extends StatelessWidget {
  const TrimTextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trim Text'),
      ),
      body: ToolWidget(
        title: 'Trim Text',
        toolFunction: (String inputText) {
          String trimmedText = inputText.replaceAll(RegExp(r'\s+'), ' ').trim();
          return trimmedText;
        },
      ),
    );
  }
}
