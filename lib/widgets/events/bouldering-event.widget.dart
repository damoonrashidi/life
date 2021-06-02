import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life/events/bouldering.event.dart';
import 'package:life/services/bouldering.service.dart';
import 'package:life/widgets/event-renderer/expandable-event.widget.dart';

class BoulderingEvent extends StatefulWidget {
  final QueryDocumentSnapshot event;

  const BoulderingEvent({Key? key, required this.event}) : super(key: key);

  @override
  State<BoulderingEvent> createState() => _BoulderingEventState();
}

class _BoulderingEventState extends State<BoulderingEvent> {
  double _highestGrade = 0;
  String gradeForValue() => boulderingGrades[_highestGrade.round()] ?? '3';
  BoulderingService boulderingService = BoulderingService();
  late Bouldering _event;

  @override
  void initState() {
    super.initState();
    _event = Bouldering.fromJSON(widget.event);
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableEvent(
        title: 'Bouldering',
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("What was your highest grade?"),
          Slider(
              value: _highestGrade,
              min: 0,
              max: 21,
              divisions: 21,
              label: gradeForValue(),
              onChanged: (double value) {
                setState(() {
                  _highestGrade = value;
                  boulderingService.setHighestGrade(_event.id, gradeForValue());
                });
              }),
          const Text("How did your session feel?"),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  boulderingService.rateEvent(_event.id, 1);
                },
                child: const Text(
                  Emojis.smile_angry_face,
                  style: TextStyle(fontSize: 22),
                ),
              ),
              TextButton(
                onPressed: () {
                  boulderingService.rateEvent(_event.id, 2);
                },
                child: const Text(
                  Emojis.smile_neutral_face,
                  style: TextStyle(fontSize: 22),
                ),
              ),
              TextButton(
                onPressed: () {
                  boulderingService.rateEvent(_event.id, 3);
                },
                child: const Text(
                  Emojis.smile_smiling_face,
                  style: TextStyle(fontSize: 22),
                ),
              )
            ],
          )
        ]));
  }
}
