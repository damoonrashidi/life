import 'dart:math';

import 'package:flutter/material.dart';
import 'package:life/events/bouldering.event.dart';
import 'package:life/events/food.event.dart';
import 'package:life/events/speed-climbing.event.dart';
import 'package:life/events/weight.event.dart';
import 'package:life/events/workout.event.dart';

class EventFinder extends StatefulWidget {
  final Function onSelect;

  const EventFinder({Key? key, required this.onSelect}) : super(key: key);

  @override
  State<EventFinder> createState() => _EventFinderState();
}

class _EventFinderState extends State<EventFinder> {
  String _query = '';
  final TextEditingController _queryController = TextEditingController();
  final Map<String, String> _types = {
    BoulderingEvent.type: "Bouldering",
    WorkoutEvent.type: "Workout",
    FoodEvent.type: "Food",
    WeightEvent.type: "Weight",
    SpeedClimbingEvent.type: "Speed climbing",
  };

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.translate(
          offset: Offset.fromDirection(3.1415 / 2, 24),
          child: Container(
              width: 390,
              padding: const EdgeInsets.only(top: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 32, color: Colors.black.withOpacity(0.1))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _makeEventList(_query.toLowerCase()),
              )),
        ),
        Container(
          child: TextField(
            controller: _queryController,
            onChanged: (String value) {
              setState(() {
                _query = _queryController.text;
              });
            },
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.clear_sharp,
                    color: Colors.black.withOpacity(.5),
                  ),
                  onPressed: () {
                    setState(() {
                      _queryController.clear();
                      _query = _queryController.text;
                    });
                  },
                ),
                icon: const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Icon(Icons.search)),
                hintText: "Find an event...",
                hintStyle: Theme.of(context).textTheme.caption,
                border: InputBorder.none),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 32,
                    offset: const Offset(0, 24),
                    color: Colors.black.withOpacity(0.1))
              ]),
        ),
      ],
    );
  }

  List<Widget> _makeEventList(String query) {
    if (query == "") {
      return [];
    }

    var list = _types.entries
        .where((event) => event.value.toLowerCase().contains(query))
        .map((event) => GestureDetector(
            onTap: () {
              widget.onSelect(event.key);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Text(event.value),
            )))
        .toList();

    return list.sublist(0, min(list.length, 3));
  }
}
