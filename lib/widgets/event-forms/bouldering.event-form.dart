import 'package:flutter/material.dart';
import 'package:life/screens/home/home.screen.dart';
import 'package:life/services/bouldering.service.dart';
import 'package:life/widgets/pill_button.dart';

class BoulderingEventForm extends StatefulWidget {
  const BoulderingEventForm({Key? key}) : super(key: key);

  @override
  State<BoulderingEventForm> createState() => _BoulderingEventFormState();
}

class _BoulderingEventFormState extends State<BoulderingEventForm> {
  final BoulderingService _boulderingService = BoulderingService();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Bouldering",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.black),
        ),
        PillButton(
            label: "Save",
            icon: const Icon(Icons.add),
            onPressed: () {
              _boulderingService.addEvent('bouldering',
                  timestamp: DateTime.now(),
                  meta: {"highestGrade": "7A+"},
                  rating: 1);
              Navigator.of(context).popAndPushNamed(HomeScreen.route);
            })
      ],
    );
  }
}
