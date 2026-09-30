import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:productivity_pal/notes/note_object.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onTap;
  final Function(Color)? onColorChange;

  const NoteItem({
    Key? key,
    required this.note,
    required this.onDelete,
    required this.onEdit,
    required this.onTap,
    this.onColorChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        color: _getColorFromString(note.backgroundColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title ?? '',
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    height: 100,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            note.content ?? '',
                            style: const TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container()), // This will push the buttons to the bottom
            Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.palette),
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                    onPressed: () => _showColorPicker(context),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                    onPressed: onEdit,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white,
                    onPressed: onDelete,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showColorPicker(BuildContext context) async {
    Color? selectedColor = await showDialog<Color?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: _getColorFromString(note.backgroundColor),
              onColorChanged: (color) {
                // Update the pickerColor
                note.backgroundColor = _getStringFromColor(color);
              },
              availableColors: const [
                Colors.red,
                Colors.deepOrange,
                Colors.orange,
                Colors.amber,
                Colors.yellow,
                Colors.lime,
                Colors.lightGreen,
                Colors.green,
                Colors.teal,
                Colors.cyan,
                Colors.lightBlue,
                Colors.blue,
                Colors.indigo,
                Colors.deepPurple,
                Colors.purple,
                Colors.pink,
                Colors.brown,
                Colors.grey,
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cancel button
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Pass the selected color to the callback
                if (onColorChange != null) {
                  onColorChange!(_getColorFromString(note.backgroundColor));
                }
                Navigator.of(context).pop(); // Select button
              },
              child: const Text('Select'),
            ),
          ],
        );
      },
    );

    // Update the note's color if a color was selected
    if (selectedColor != null) {
      note.backgroundColor = _getStringFromColor(selectedColor);
    }
  }

  Color _getColorFromString(String colorString) {
    switch (colorString.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'orange':
        return Colors.orange;
      case 'yellow':
        return Colors.yellow;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'purple':
        return Colors.purple;
      case 'pink':
        return Colors.pink;
      case 'teal':
        return Colors.teal;
      case 'deeppurple':
        return Colors.deepPurple;
      case 'amber':
        return Colors.amber;
      case 'cyan':
        return Colors.cyan;
      case 'lime':
        return Colors.lime;
      case 'indigo':
        return Colors.indigo;
      case 'lightblue':
        return Colors.lightBlue;
      case 'lightgreen':
        return Colors.lightGreen;
      case 'deeporange':
        return Colors.deepOrange;
      case 'brown':
        return Colors.brown;
      case 'grey':
        return Colors.grey;
      default:
        return Colors.grey; // Default to white
    }
  }

  String _getStringFromColor(Color color) {
    if (color == Colors.red) return 'red';
    if (color == Colors.orange) return 'orange';
    if (color == Colors.yellow) return 'yellow';
    if (color == Colors.green) return 'green';
    if (color == Colors.blue) return 'blue';
    if (color == Colors.purple) return 'purple';
    if (color == Colors.pink) return 'pink';
    if (color == Colors.teal) return 'teal';
    if (color == Colors.deepPurple) return 'deeppurple';
    if (color == Colors.amber) return 'amber';
    if (color == Colors.cyan) return 'cyan';
    if (color == Colors.lime) return 'lime';
    if (color == Colors.indigo) return 'indigo';
    if (color == Colors.lightBlue) return 'lightblue';
    if (color == Colors.lightGreen) return 'lightgreen';
    if (color == Colors.deepOrange) return 'deeporange';
    if (color == Colors.brown) return 'brown';
    if (color == Colors.grey) return 'grey';
    return 'grey'; // Default to white
  }
}
