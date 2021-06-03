import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life/events/bouldering.event.dart';
import 'package:life/services/bouldering.service.dart';
import 'package:life/widgets/rating/rating.widget.dart';

class BoulderingEvent extends StatefulWidget {
  final QueryDocumentSnapshot event;

  const BoulderingEvent({Key? key, required this.event}) : super(key: key);

  @override
  State<BoulderingEvent> createState() => _BoulderingEventState();
}

class _BoulderingEventState extends State<BoulderingEvent> {
  double _highestGrade = 0;
  String gradeForValue() => boulderingGrades[_highestGrade.round()];
  BoulderingService boulderingService = BoulderingService();
  late Bouldering _event;

  @override
  void initState() {
    super.initState();
    _event = Bouldering.fromJSON(widget.event);
    _highestGrade = _stepFromGrade(_event.highestGrade);
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          const Text("What was your highest grade?"),
          Text(gradeForValue())
        ],
      ),
      Slider(
          value: _highestGrade,
          min: 0,
          max: 21,
          divisions: 21,
          label: gradeForValue(),
          onChanged: (double value) {
            setState(() {
              _highestGrade = value;
            });
          },
          onChangeEnd: (double value) {
            boulderingService.setHighestGrade(_event.id, gradeForValue());
          }),
      const Text("How did your session feel?"),
      RatingWidget(event: _event)
    ]);
  }

  double _stepFromGrade(String grade) {
    var index = boulderingGrades.indexOf(grade).toDouble();
    return index;
  }
}
