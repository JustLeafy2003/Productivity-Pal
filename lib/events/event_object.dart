class CustomEvent {
  int? eventID;
  String? title;
  String? description;
  int userID;

  // Add non-nullable year, month, and day properties
  int year;
  int month;
  int day;

  CustomEvent({
    this.eventID,
    this.title,
    this.description,
    required this.userID,
    required this.year,
    required this.month,
    required this.day,
  });

  Map<String, dynamic> toMap() {
    return {
      'event_id': eventID,
      'title': title,
      'description': description,
      'year': year,
      'month': month,
      'day': day,
      'user_id': userID,
    };
  }
}
