import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import '../user/user_service.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// ignore: constant_identifier_names
enum ToolType { PaintBrush }

class DrawingScreen extends StatefulWidget {
  final int userId;
  final UserService userService;
  final bool isDarkMode;

  const DrawingScreen({
    required this.userId,
    required this.userService,
    required this.isDarkMode,
    Key? key,
  }) : super(key: key);

  @override
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  final DrawingController _controller = DrawingController();
  Color _currentColor = Colors.black;
  double _currentStrokeWidth = 4.0;
  ToolType _currentTool = ToolType.PaintBrush;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Drawing Board'),
            const SizedBox(width: 16), // Add space
            const VerticalDivider(color: Colors.grey), // Add vertical divider
            const SizedBox(width: 16), // Add space
            IconButton(
              icon: Icon(Icons.brush,
                  color: _currentTool == ToolType.PaintBrush
                      ? Colors.blue
                      : Colors.black),
              onPressed: () {
                setState(() {
                  _currentTool = ToolType.PaintBrush;
                });
              },
            ),
            Slider(
              value: _currentStrokeWidth,
              min: 1.0,
              max: 20.0,
              onChanged: (value) {
                setState(() {
                  _currentStrokeWidth = value;
                });
                _controller.setStyle(strokeWidth: value);
              },
            ),
            IconButton(
              // Move color selection button next to slider
              icon: const Icon(Icons.color_lens),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pick a color'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: _currentColor,
                          onColorChanged: (color) {
                            setState(() {
                              _currentColor = color;
                            });
                            _controller.setStyle(color: color);
                          },
                          pickerAreaHeightPercent: 0.8,
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Done'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.undo),
              onPressed: _controller.undo,
            ),
            IconButton(
              icon: const Icon(Icons.redo),
              onPressed: _controller.redo,
            ),
            IconButton(
              icon: const Icon(Icons.rotate_right),
              onPressed: _controller.turn,
            ),
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: _controller.clear,
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: DrawingBoard(
                  controller: _controller,
                  background: Container(
                    color: widget.isDarkMode ? Colors.black : Colors.white,
                    width: 1168,
                    height: 800,
                  ),
                  showDefaultActions: false,
                  showDefaultTools: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
