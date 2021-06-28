import 'package:flutter/material.dart';

class PillButton extends StatelessWidget {
  final String label;
  final Widget icon;

  const PillButton({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () {},
        icon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: icon,
        ),
        label: Padding(
          padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
          child: Text(label),
        ),
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(12),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32))),
            backgroundColor:
                MaterialStateColor.resolveWith((states) => Colors.blue)));
  }
}
