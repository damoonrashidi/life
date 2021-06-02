import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const Map<int, String> ratingMap = {
  0: Emojis.smile_frowning_face,
  1: Emojis.smile_neutral_face,
  2: Emojis.smile_smiling_face,
};

Set<String> eventTypes = <String>{'bouldering', 'food'};

abstract class BaseEvent {
  static String type = 'event';

  abstract String title;
  abstract DateTime timestamp;
  abstract int rating;

  BaseEvent.fromJSON(DocumentSnapshot<Map<String, dynamic>> data);
}
