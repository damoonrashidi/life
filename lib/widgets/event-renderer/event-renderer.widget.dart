import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life/widgets/event-renderer/expandable-event.widget.dart';
import 'package:life/widgets/events/bouldering-event.widget.dart';
import 'package:life/widgets/events/food-event.widget.dart';
import 'package:life/widgets/events/speed-climbing-event.widget.dart';
import 'package:life/widgets/events/undetermined-event.widget.dart';
import 'package:life/widgets/events/weight-event.widget.dart';

class EventRenderer extends StatelessWidget {
  final QueryDocumentSnapshot event;

  const EventRenderer({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("EventsRenderer: ${event['rating']}");

    Widget child = UndeterminedEvent(event: event);
    String title = "Undetermined event";

    switch (event['type']) {
      case "bouldering":
        child = BoulderingEvent(event: event);
        title = 'Bouldering';
        break;

      case "speed-climbing":
        child = SpeedClimbingEvent(event: event);
        title = 'Speed Climbing';
        break;

      case "food":
        child = FoodEvent(event: event);
        title = 'Food';
        break;

      case "weight":
        child = WeightEvent(event: event);
        title = 'Weight';
        break;
    }

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ExpandableEvent(title: title, child: child));
  }
}
