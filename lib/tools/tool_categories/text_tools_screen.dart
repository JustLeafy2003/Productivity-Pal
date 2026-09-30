import 'package:flutter/material.dart';
import 'text_tools/find_and_replace_screen.dart';
import 'text_tools/word_counter_screen.dart';
import 'text_tools/trim_text_screen.dart';
import 'text_tools/reverse_text_screen.dart';

class TextToolsScreen extends StatelessWidget {
  const TextToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Tools'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FindAndReplaceScreen()),
                      );
                    },
                    icon: const Icon(Icons.find_replace),
                    label: const Text(
                      'Find and Replace',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color.fromARGB(255, 240, 237, 240)
                              : const Color.fromARGB(255, 42, 40, 47),
                    ),
                  ),
                  const SizedBox(
                      height: 16), // Add vertical spacing between buttons
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WordCounterScreen()),
                      );
                    },
                    icon: const Icon(Icons.numbers),
                    label: const Text(
                      'Word Counter',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color.fromARGB(255, 240, 237, 240)
                              : const Color.fromARGB(255, 42, 40, 47),
                    ),
                  ),
                  const SizedBox(
                      height: 16), // Add vertical spacing between buttons
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TrimTextScreen()),
                      );
                    },
                    icon: const Icon(Icons.format_align_center),
                    label: const Text(
                      'Trim Text',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color.fromARGB(255, 240, 237, 240)
                              : const Color.fromARGB(255, 42, 40, 47),
                    ),
                  ),
                  const SizedBox(
                      height: 16), // Add vertical spacing between buttons
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReverseTextScreen()),
                      );
                    },
                    icon: const Icon(Icons.swap_horiz),
                    label: const Text(
                      'Reverse Text',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.light
                              ? const Color.fromARGB(255, 240, 237, 240)
                              : const Color.fromARGB(255, 42, 40, 47),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
