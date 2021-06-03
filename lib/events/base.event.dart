import 'package:cloud_firestore/cloud_firestore.dart';

Set<String> eventTypes = <String>{'bouldering', 'food', 'weight'};

abstract class BaseEvent {
  static String type = 'event';

  abstract String id;
  abstract String title;
  abstract DateTime timestamp;
  abstract int rating;

  BaseEvent.fromJSON(DocumentSnapshot<Map<String, dynamic>> data);
}
