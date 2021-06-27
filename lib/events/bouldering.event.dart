import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life/events/base.event.dart';

const List<String> boulderingGrades = [
  '3',
  '4',
  '5',
  '6A',
  '6A+',
  '6B',
  '6B+',
  '6C',
  '6C+',
  '7A',
  '7A+',
  '7B',
  '7B+',
  '7C',
  '7C+',
  '8A',
  '8A+',
  '8B',
  '8B+'
];

class BoulderingEvent implements BaseEvent {
  static const String type = 'bouldering';

  @override
  late String id;

  @override
  String title = 'Bouldering';

  @override
  late String subtitle;

  @override
  String icon = '🧗';

  @override
  late DateTime timestamp;

  @override
  int rating = 1;

  bool completed = false;
  late String highestGrade;

  BoulderingEvent.fromJSON(QueryDocumentSnapshot data) {
    rating = data['rating'];
    timestamp =
        DateTime.fromMillisecondsSinceEpoch(data['timestamp'].seconds * 1000);
    id = data.id;
    highestGrade = data['meta']?['highestGrade'] ?? '3';

    subtitle = 'Your highest grade was $highestGrade';
  }
}
