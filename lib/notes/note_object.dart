class Note {
  int? noteID;
  String? title;
  String? content;
  String? creationDate;
  String backgroundColor; // Add background color property
  int userId;

  Note({
    this.noteID,
    this.title,
    this.content,
    this.creationDate,
    this.backgroundColor = 'white', // Default color is 'white'
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'note_id': noteID,
      'title': title,
      'content': content,
      'creation_date': creationDate,
      'background_color': backgroundColor,
      'user_id': userId,
    };
  }
}
