import 'package:flutter/material.dart';
import 'tool_categories/text_tools_screen.dart';
import 'tool_categories/unit_conversion_tools.dart';
import 'tool_categories/math_tools_screen.dart';
import '../user/user_service.dart';

class ToolScreen extends StatelessWidget {
  final int userId;
  final UserService userService;

  const ToolScreen({
    required this.userId,
    required this.userService,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tools'),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWideScreen = constraints.maxWidth > 800;
            return Theme(
              data: Theme.of(context).copyWith(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: isWideScreen
                    ? _buildHorizontalButtons(context)
                    : _buildVerticalButtons(context),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHorizontalButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ToolButton(
          title: 'Text Tools',
          icon: Icons.text_fields,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TextToolsScreen()),
            );
          },
        ),
        const SizedBox(width: 16),
        ToolButton(
          title: 'Unit Conversion Tools',
          icon: Icons.compare_arrows,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const UnitConversionToolsScreen()),
            );
          },
        ),
        const SizedBox(width: 16),
        ToolButton(
          title: 'Math Tools',
          icon: Icons.calculate,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MathToolsScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildVerticalButtons(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ToolButton(
          title: 'Text Tools',
          icon: Icons.text_fields,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TextToolsScreen()),
            );
          },
        ),
        const SizedBox(height: 16),
        ToolButton(
          title: 'Unit Conversion Tools',
          icon: Icons.compare_arrows,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const UnitConversionToolsScreen()),
            );
          },
        ),
        const SizedBox(height: 16),
        ToolButton(
          title: 'Math Tools',
          icon: Icons.calculate,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MathToolsScreen()),
            );
          },
        ),
      ],
    );
  }
}

class ToolButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const ToolButton({
    required this.title,
    required this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final backgroundColor = isLightTheme
        ? const Color.fromARGB(255, 240, 237, 240)
        : const Color.fromARGB(255, 42, 40, 47);
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
