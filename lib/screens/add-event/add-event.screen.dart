import 'package:flutter/material.dart';
import 'package:life/widgets/event-finder.widget.dart';
import 'package:life/widgets/event-forms/bouldering.event-form.dart';

class AddEventScreen extends StatefulWidget {
  static String route = '/add-event';

  const AddEventScreen({Key? key}) : super(key: key);

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  String? _eventType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: EventFinder(onSelect: (String type) {
                setState(() {
                  _eventType = type;
                });
              }),
            ),
            _formForEvent(_eventType)
          ],
        ),
      ),
    );
  }

  Widget _formForEvent(String? type) {
    if (type == null) {
      return const Center(
        child: Text("Select an event to start logging"),
      );
    }

    if (type == "bouldering") {
      return const BoulderingEventForm();
    }

    return Center(
      child: RichText(
        text: TextSpan(children: [
          const TextSpan(
              text: "No form for ", style: TextStyle(color: Colors.black)),
          TextSpan(
              text: type,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black)),
          const TextSpan(text: " yet", style: TextStyle(color: Colors.black))
        ]),
      ),
    );
  }
}
