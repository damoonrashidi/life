import 'package:flutter/material.dart';

class AddEventScreen extends StatelessWidget {
  static String route = '/add-event';

  const AddEventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Add event")),
    );
  }
}
