import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life/widgets/events/bouldering-event.widget.dart';
import 'package:life/widgets/events/undetermined-event.widget.dart';

class EventRenderer extends StatelessWidget {
  final QueryDocumentSnapshot event;

  const EventRenderer({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (event['type']) {
      case "bouldering":
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: BoulderingEvent(event: event));

      default:
        return UndeterminedEvent(event: event);
    }
  }
}
