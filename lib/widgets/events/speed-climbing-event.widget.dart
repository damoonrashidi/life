import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life/events/speed-climbing.event.dart';
import 'package:life/services/events.service.dart';
import 'package:life/widgets/rating/rating.widget.dart';

class SpeedClimbingEvent extends StatefulWidget {
  final QueryDocumentSnapshot event;

  const SpeedClimbingEvent({Key? key, required this.event}) : super(key: key);

  @override
  State<SpeedClimbingEvent> createState() => _SpeedClimbingEventState();
}

class _SpeedClimbingEventState extends State<SpeedClimbingEvent> {
  late SpeedClimbing _event;
  final EventsService _eventsService = EventsService();

  @override
  void initState() {
    super.initState();
    _event = SpeedClimbing.fromJSON(widget.event);
  }

  @override
  Widget build(BuildContext context) {
    print("SpeedClimbing: ${_event.rating}");

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text("What was your best speed?"),
      TextFormField(
        initialValue: _event.time.toString(),
        onFieldSubmitted: (String value) {
          _eventsService.setMeta(_event.id, {"time": double.parse(value)});
        },
      ),
      const Text("How did it feel?"),
      RatingWidget(
          rating: _event.rating,
          onRating: (int rating) {
            _eventsService.rateEvent(_event.id, rating);
          }),
    ]);
  }
}
