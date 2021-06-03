import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life/events/food.event.dart';
import 'package:life/services/events.service.dart';
import 'package:life/widgets/rating/rating.widget.dart';

class FoodEvent extends StatefulWidget {
  final QueryDocumentSnapshot event;

  const FoodEvent({Key? key, required this.event}) : super(key: key);

  @override
  State<FoodEvent> createState() => _FoodEventState();
}

class _FoodEventState extends State<FoodEvent> {
  String description = '';
  late Food _event;
  final EventsService _eventsService = EventsService();
  final TextEditingController _descriptionController =
      TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    _event = Food.fromJSON(widget.event);
    _descriptionController.text = _event.description;
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text("What did you eat?"),
      TextFormField(
        controller: _descriptionController,
        onChanged: (String value) {
          var meta = {
            "description": value,
            "calories": _event.calories,
          };
          _eventsService.setMeta(_event.id, meta);
        },
      ),
      const Text("How was your meal?"),
      RatingWidget(event: _event),
    ]);
  }
}
