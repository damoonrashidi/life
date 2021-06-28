import 'package:flutter/material.dart';
import 'package:life/events/base.event.dart';

class EventRenderer extends StatelessWidget {
  final BaseEvent event;

  const EventRenderer({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 4,
                  blurRadius: 24,
                  offset: const Offset(0, 24))
            ]),
        width: MediaQuery.of(context).size.width * .7,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(event.title,
                    style: Theme.of(context).textTheme.subtitle1),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(event.subtitle,
                    style: Theme.of(context).textTheme.caption),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoundedHolder(
                      child: Text(
                    event.icon,
                    style: const TextStyle(fontSize: 21),
                  )),
                  Row(
                    children: [
                      RoundedHolder(
                        child: Image.asset(
                          'assets/images/icons/rating_${event.rating}.png',
                          width: 21,
                        ),
                      ),
                      TextButton(
                          child: Image.asset(
                            'assets/images/icons/pencil.png',
                            width: 21,
                          ),
                          onPressed: () {},
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(12)),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.black.withOpacity(0.03)),
                              shape: MaterialStateProperty.all<CircleBorder>(
                                  const CircleBorder()))),
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}

class RoundedHolder extends StatelessWidget {
  final Widget child;

  const RoundedHolder({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
      ),
      child: child,
    );
  }
}
