import 'package:flutter/material.dart';
import '../user/user_service.dart';
import '../notes/note_object.dart';
import '../notes/note_service.dart';
import '../notes/note_widget.dart';

class NoteScreen extends StatefulWidget {
  final int userId;
  final UserService userService;
  final NoteService noteService;
  final bool isDarkMode;

  const NoteScreen({
    Key? key,
    required this.userId,
    required this.userService,
    required this.noteService,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late Future<List<Note>> _notesFuture;
  late List<Note> _notes = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String _title = '';
  String _content = '';

  @override
  void initState() {
    super.initState();
    _notesFuture = _loadNotes();
    _titleController.addListener(() {
      _title = _titleController.text;
    });
    _contentController.addListener(() {
      _content = _contentController.text;
    });
  }

  Future<List<Note>> _loadNotes() async {
    return widget.noteService.getAllNotes(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = widget.isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<Note>>(
            future: _notesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error loading notes'),
                );
              } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('No notes available'),
                      const SizedBox(
                        height: 16.0,
                      ),
                      SizedBox(
                        width: 150.0,
                        child: _buildAddNoteButton(isDarkMode),
                      ),
                    ],
                  ),
                );
              } else {
                _notes = snapshot.data!;
                return LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = (constraints.maxWidth / 200).floor();
                    return Column(
                      children: [
                        GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: _notes.length + 1,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (index == _notes.length) {
                              return _buildAddNoteButton(isDarkMode);
                            } else {
                              final note = _notes[index];
                              return NoteItem(
                                note: note,
                                onDelete: () => _deleteNote(note),
                                onEdit: () => _showEditNoteDialog(note),
                                onTap: () => _showNoteDetails(context, note),
                                // isDarkMode: isDarkMode,
                                onColorChange: (color) =>
                                    _changeNoteColor(note, color),
                              );
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAddNoteButton(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        color: isDarkMode
            ? const Color.fromARGB(255, 37, 35, 42)
            : const Color.fromARGB(255, 227, 222, 229),
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: _showAddNoteDialog, // Directly call the method
          child: SizedBox(
            height: 66.0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add,
                      color: isDarkMode
                          ? const Color.fromARGB(255, 247, 242, 249)
                          : const Color.fromARGB(255, 37, 35, 42)),
                  const SizedBox(width: 8.0),
                  Text(
                    'Add Note',
                    style: TextStyle(
                      color: isDarkMode
                          ? const Color.fromARGB(255, 247, 242, 249)
                          : const Color.fromARGB(255, 37, 35, 42),
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _deleteNote(Note note) async {
    bool confirmDelete = false; // Default value

    // Show dialog
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Note'),
          content: const Text('Are you sure you want to delete this note?'),
          actions: [
            TextButton(
              onPressed: () {
                // Dismiss dialog and set confirmDelete to false
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Dismiss dialog and set confirmDelete to true
                Navigator.pop(context, true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    ).then((value) {
      // Handle result from dialog
      if (value != null && value is bool) {
        confirmDelete = value;
      }
    });

    // Proceed with deletion if confirmDelete is true
    if (confirmDelete) {
      // Delete note
      await widget.noteService.deleteNote(note.noteID!);
      setState(() {
        _notes.remove(note);
      });
    }
  }

  Future<void> _showAddNoteDialog() async {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Note'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  maxLength: 50,
                ),
                TextField(
                  controller: contentController,
                  decoration: const InputDecoration(labelText: 'Content'),
                  minLines: 1,
                  maxLines: 5,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Close the dialog
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Note note = Note(
                  title: titleController.text.trim(),
                  content: contentController.text.trim(),
                  userId: widget.userId,
                );

                await widget.noteService.addNote(note, widget.userId);
                setState(() {
                  _notesFuture = _loadNotes(); // Reload notes after adding
                });
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditNoteDialog(Note note) async {
    _titleController.text = note.title ?? '';
    _contentController.text = note.content ?? '';
    _title = note.title ?? '';
    _content = note.content ?? '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Note'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _title = value;
                    });
                  },
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  maxLength: 50,
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _content = value;
                    });
                  },
                  controller: _contentController,
                  decoration: const InputDecoration(labelText: 'Content'),
                  minLines: 1,
                  maxLines: 5,
                ),
                // ElevatedButton(
                //   onPressed: () => _showColorPicker(context, note),
                //   child: const Text('Change Color'),
                // ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Close the dialog
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                note.title = _title.trim();
                note.content = _content.trim();

                await widget.noteService.updateNote(note);
                setState(() {});
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showNoteDetails(BuildContext context, Note note) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(note.title ?? ''),
          content: Text(note.content ?? ''),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  String _getStringFromColor(Color color) {
    if (color == Colors.red) return 'red';
    if (color == Colors.deepOrange) return 'deepOrange';
    if (color == Colors.orange) return 'orange';
    if (color == Colors.amber) return 'amber';
    if (color == Colors.yellow) return 'yellow';
    if (color == Colors.lime) return 'lime';
    if (color == Colors.lightGreen) return 'lightGreen';
    if (color == Colors.green) return 'green';
    if (color == Colors.teal) return 'teal';
    if (color == Colors.cyan) return 'cyan';
    if (color == Colors.lightBlue) return 'lightBlue';
    if (color == Colors.blue) return 'blue';
    if (color == Colors.indigo) return 'indigo';
    if (color == Colors.deepPurple) return 'deepPurple';
    if (color == Colors.purple) return 'purple';
    if (color == Colors.pink) return 'pink';
    if (color == Colors.brown) return 'brown';
    if (color == Colors.grey) return 'grey';

    return 'white'; // Default to white
  }

  // Define the _changeNoteColor method here
// Define the _changeNoteColor method here
  void _changeNoteColor(Note note, Color color) async {
    setState(() {
      note.backgroundColor = _getStringFromColor(color);
    });
    await widget.noteService.updateNote(note);
  }
}
