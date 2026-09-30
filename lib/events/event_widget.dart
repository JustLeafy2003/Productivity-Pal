import 'package:flutter/material.dart';
// import 'package:flutter_event_calendar/flutter_event_calendar.dart' as event_calendar;
import 'event_object.dart';

class EventWidget extends StatelessWidget {
  final CustomEvent event;

  const EventWidget({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(event.title ?? ''),
      subtitle: Text(event.description ?? ''),
      trailing: const Icon(
          Icons.event), // Use Icons.event directly from flutter/material.dart
      onTap: () {
        // Handle onTap event if needed
      },
    );
  }
}
