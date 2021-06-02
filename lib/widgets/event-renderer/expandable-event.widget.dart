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
  double _height = 53;
  bool _isExpanded = false;

  void expand() {
    setState(() {
      if (_isExpanded) {
        _isExpanded = false;
        _height = 53;
      } else {
        _isExpanded = true;
        _height = 200;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        height: _height,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4)),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(222, 239, 255, 100),
                spreadRadius: 2,
                blurRadius: 8)
          ],
        ),
        child: ListView(
          children: [
            GestureDetector(
                onTap: () {
                  expand();
                },
                child: Text(
                  widget.title,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                )),
            widget.child
          ],
        ));
  }
}
