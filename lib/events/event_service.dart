import 'event_object.dart';
import 'event_repository.dart';

class EventService {
  final EventRepository _repository;

  EventService(this._repository);

  Future<List<CustomEvent>> getEvents(int userId) async {
    return await _repository.getEvents(userId);
  }

  Future<void> addEvent(CustomEvent event, int userId) async {
    await _repository.insertEvent(event, userId);
  }

  Future<void> deleteEvent(int eventID) async {
    await _repository.deleteEvent(eventID);
  }

  Future<void> updateEvent(CustomEvent event) async {
    await _repository.updateEvent(event);
  }
}
