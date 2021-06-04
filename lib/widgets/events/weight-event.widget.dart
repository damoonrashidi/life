import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life/events/weight.event.dart';
import 'package:life/services/events.service.dart';
import 'package:life/widgets/rating/rating.widget.dart';

class WeightEvent extends StatefulWidget {
  final QueryDocumentSnapshot event;

  const WeightEvent({Key? key, required this.event}) : super(key: key);

  @override
  State<WeightEvent> createState() => _WeightEventState();
}

class _WeightEventState extends State<WeightEvent> {
  late Weight _event;
  final EventsService _eventsService = EventsService();

  @override
  void initState() {
    super.initState();
    _event = Weight.fromJSON(widget.event);
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text("What did you weigh?"),
      TextFormField(
        initialValue: _event.weight.toString(),
        keyboardType: TextInputType.number,
        onSaved: (String? value) {
          var weight = 0.0;
          if (value != null) {
            double.parse(value);
          }

          _eventsService.setMeta(_event.id, {"weight": weight});
        },
      ),
      const Text("How did your weigh in feel?"),
      RatingWidget(
          event: _event,
          onRating: (int rating) {
            _eventsService.rateEvent(_event.id, rating);
          })
    ]);
  }
}
