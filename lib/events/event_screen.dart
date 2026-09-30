import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import '../user/user_service.dart';
import '../events/event_service.dart';
import '../events/event_object.dart';

class EventScreen extends StatefulWidget {
  final int userId;
  final UserService userService;
  final EventService eventService;
  final bool isDarkMode;

  const EventScreen({
    required this.userId,
    required this.userService,
    required this.eventService,
    required this.isDarkMode,
    Key? key,
  }) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  late Future<List<CustomEvent>> _eventsFuture;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime? _selectedDate; // Track selected date from the calendar

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _eventsFuture = widget.eventService.getEvents(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Event Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: EventCalendar(
                          events: const [],
                          onChangeDateTime: (CalendarDateTime dateTime) {
                            _handleCalendarDateTimeChange(dateTime);
                          },
                          eventOptions: EventOptions(
                            emptyIconColor: Colors.transparent,
                            emptyTextColor:
                                Theme.of(context).colorScheme.background,
                          ),
                          calendarType: CalendarType.GREGORIAN,
                          calendarOptions: CalendarOptions(
                            headerMonthBackColor: widget.isDarkMode
                                ? const Color.fromARGB(255, 32, 30, 37)
                                : const Color.fromARGB(255, 250, 247, 250),
                            headerMonthShadowColor: widget.isDarkMode
                                ? const Color.fromARGB(255, 32, 30, 37)
                                : const Color.fromARGB(255, 250, 247, 250),
                            headerMonthElevation: 4.0,
                          ),
                          headerOptions: HeaderOptions(
                            headerTextColor:
                                widget.isDarkMode ? Colors.white : Colors.black,
                            navigationColor:
                                widget.isDarkMode ? Colors.white : Colors.black,
                          ),
                          dayOptions: DayOptions(
                            weekDaySelectedColor:
                                widget.isDarkMode ? Colors.white : Colors.black,
                            weekDayUnselectedColor:
                                widget.isDarkMode ? Colors.blue : Colors.blue,
                            selectedBackgroundColor:
                                widget.isDarkMode ? Colors.blue : Colors.blue,
                            unselectedBackgroundColor: widget.isDarkMode
                                ? Colors.transparent
                                : Colors.transparent,
                            selectedTextColor:
                                widget.isDarkMode ? Colors.white : Colors.black,
                            unselectedTextColor:
                                widget.isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -200.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: widget.isDarkMode
                                  ? Colors.black.withOpacity(1)
                                  : Colors.white.withOpacity(1),
                              boxShadow: widget.isDarkMode
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 4.0,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        blurRadius: 4.0,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: FutureBuilder<List<CustomEvent>>(
                              future: _eventsFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                } else {
                                  final events = snapshot.data ?? [];
                                  final filteredEvents = events.where((event) =>
                                      event.year == _selectedDate?.year &&
                                      event.month == _selectedDate?.month &&
                                      event.day == _selectedDate?.day);
                                  if (filteredEvents.isEmpty) {
                                    return const Center(
                                      child: Text(
                                        'No events for selected date',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: filteredEvents.length,
                                      itemBuilder: (context, index) {
                                        final event =
                                            filteredEvents.elementAt(index);
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: ListTile(
                                            title:
                                                Text(event.title ?? 'No Title'),
                                            subtitle: Text(
                                              event.description ??
                                                  'No Description',
                                            ),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  icon: const Icon(Icons.edit),
                                                  onPressed: () {
                                                    _showEditEventDialog(
                                                        context, event);
                                                  },
                                                ),
                                                IconButton(
                                                  icon:
                                                      const Icon(Icons.delete),
                                                  onPressed: () {
                                                    _showDeleteConfirmationDialog(
                                                        context, event.eventID);
                                                  },
                                                ),
                                              ],
                                            ),
                                            onTap: () {
                                              _showEventDetailsDialog(
                                                  context, event);
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton.extended(
            onPressed: () => _showAddEventDialog(context),
            icon: const Icon(Icons.add),
            label: const Text('Add Event'),
          ),
        ),
      ),
    );
  }

  void _handleCalendarDateTimeChange(CalendarDateTime newDate) {
    setState(() {
      _selectedDate = DateTime(
        newDate.year,
        newDate.month,
        newDate.day,
      );
    });
  }

  void _showAddEventDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';
        String description = '';
        return AlertDialog(
          title: const Text('Add Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (value) => title = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) => description = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _saveEvent(title, description);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showEditEventDialog(BuildContext context, CustomEvent event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = event.title ?? '';
        String description = event.description ?? '';
        return AlertDialog(
          title: const Text('Edit Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (value) => title = value,
                controller: TextEditingController(text: title),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) => description = value,
                controller: TextEditingController(text: description),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _saveEditedEvent(event.eventID, title, description);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int? eventID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Event'),
          content: const Text('Are you sure you want to delete this event?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteEvent(eventID);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _saveEvent(String title, String description) {
    _addEvent(title, description);
  }

  void _addEvent(String title, String description) {
    if (_selectedDate != null) {
      CustomEvent newEvent = CustomEvent(
        title: title,
        description: description,
        userID: widget.userId,
        year: _selectedDate!.year,
        month: _selectedDate!.month,
        day: _selectedDate!.day,
      );

      widget.eventService.addEvent(newEvent, widget.userId);
      setState(() {
        _eventsFuture = widget.eventService.getEvents(widget.userId);
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please select a date before adding an event.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void _saveEditedEvent(int? eventID, String title, String description) {
    if (eventID != null) {
      _editEvent(eventID, title, description);
    }
  }

  void _editEvent(int eventId, String title, String description) {
    CustomEvent editedEvent = CustomEvent(
      eventID: eventId,
      title: title,
      description: description,
      userID: widget.userId,
      year: _selectedDate?.year ?? DateTime.now().year,
      month: _selectedDate?.month ?? DateTime.now().month,
      day: _selectedDate?.day ?? DateTime.now().day,
    );

    widget.eventService.updateEvent(editedEvent).then((_) {
      setState(() {
        _eventsFuture = widget.eventService.getEvents(widget.userId);
      });
    });
  }

  void _deleteEvent(int? eventID) {
    if (eventID != null) {
      widget.eventService.deleteEvent(eventID).then((_) {
        setState(() {
          _eventsFuture = widget.eventService.getEvents(widget.userId);
        });
      });
    }
  }

  void _showEventDetailsDialog(BuildContext context, CustomEvent event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(event.title ?? 'No Title'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(event.description ?? 'No Description'),
              const SizedBox(height: 8),
              Text('Event Date: ${_formattedDate(event)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  String _formattedDate(CustomEvent event) {
    return '${event.year}-${event.month}-${event.day}';
  }
}
