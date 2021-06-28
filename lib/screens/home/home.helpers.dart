import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life/events/base.event.dart';
import 'package:life/events/bouldering.event.dart';
import 'package:life/events/food.event.dart';
import 'package:life/events/speed-climbing.event.dart';
import 'package:life/events/weight.event.dart';
import 'package:life/events/workout.event.dart';

Map<DateTime, List<BaseEvent>> groupByDate(
    List<QueryDocumentSnapshot<Object?>> events) {
  var map = Map<DateTime, List<BaseEvent>>();

  events.forEach((data) {
    BaseEvent event = toEvent(data);
    var date = DateTime(
        event.timestamp.year, event.timestamp.month, event.timestamp.day);

    map.putIfAbsent(date, () => []);
    map[date]!.add(event);
  });

  return map;
}

BaseEvent toEvent(QueryDocumentSnapshot<Object?> data) {
  switch (data['type']) {
    case "bouldering":
      return BoulderingEvent.fromJSON(data);

    case "speed-climbing":
      return SpeedClimbingEvent.fromJSON(data);

    case "food":
      return FoodEvent.fromJSON(data);

    case "weight":
      return WeightEvent.fromJSON(data);

    case "workout":
      return WorkoutEvent.fromJSON(data);
  }

  throw ("Could not determine event type for ${data['type']}");
}
