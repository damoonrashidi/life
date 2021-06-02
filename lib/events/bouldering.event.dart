import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life/events/base.event.dart';

const Map<int, String> boulderingGrades = {
  0: '3',
  1: '3+',
  2: '4',
  3: '4+',
  4: '5',
  5: '5+',
  6: '6A',
  7: '6A+',
  8: '6B',
  9: '6B+',
  10: '6C',
  11: '6C+',
  12: '7A',
  13: '7A+',
  14: '7B',
  15: '7B+',
  16: '7C',
  17: '7C+',
  18: '8A',
  19: '8A+',
  20: '8B',
  21: '8B+',
};

class Bouldering implements BaseEvent {
  static const String type = 'bouldering';

  @override
  late String id;

  @override
  String title = 'Bouldering';

  @override
  late DateTime timestamp;

  @override
  int rating = 1;

  bool completed = false;
  String highestGrade = '3';

  Bouldering.fromJSON(QueryDocumentSnapshot data) {
    rating = data['rating'];
    timestamp =
        DateTime.fromMillisecondsSinceEpoch(data['timestamp'].seconds * 1000);
    id = data.id;
    highestGrade = data['meta']?['highestRating'] ?? '3';
  }
}
