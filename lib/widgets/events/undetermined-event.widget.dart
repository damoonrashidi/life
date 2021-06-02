import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UndeterminedEvent extends StatelessWidget {
  final QueryDocumentSnapshot event;

  const UndeterminedEvent({Key? key, required this.event}) : super(key: key);

  @override
  build(BuildContext context) {
    return const Text("Cannot determine event type");
  }
}
