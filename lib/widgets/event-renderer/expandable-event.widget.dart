import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

class ExpandableEvent extends StatefulWidget {
  final Widget child;
  final String title;

  const ExpandableEvent({Key? key, required this.child, required this.title})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ExpandableEventState();
}

class ExpandableEventState extends State<ExpandableEvent> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      baseColor: Colors.white,
      title: Text(widget.title,
          style: const TextStyle(fontSize: 16, color: Colors.grey)),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: widget.child,
        )
      ],
    );
  }
}
