import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life/services/events.service.dart';
import 'package:life/widgets/event-renderer/expandable-event.widget.dart';
import 'package:life/widgets/events/bouldering-event.widget.dart';
import 'package:life/widgets/events/food-event.widget.dart';
import 'package:life/widgets/events/undetermined-event.widget.dart';
import 'package:life/widgets/events/weight-event.widget.dart';

class EventRenderer extends StatelessWidget {
  final QueryDocumentSnapshot event;
  final EventsService _eventsService = EventsService();

  EventRenderer({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = UndeterminedEvent(event: event);
    String title = "Undetermined event";

    switch (event['type']) {
      case "bouldering":
        child = BoulderingEvent(event: event);
        title = 'Bouldering';
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

    return GestureDetector(
      onLongPress: () {
        _eventsService.deleteEvent(event.id);
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ExpandableEvent(title: title, child: child)),
    );
  }
}
