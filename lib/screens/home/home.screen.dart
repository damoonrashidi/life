import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life/screens/add-event/add-event.screen.dart';
import 'package:life/screens/home/home.header.dart';
import 'package:life/screens/home/home.helpers.dart';
import 'package:life/services/events.service.dart';
import 'package:life/widgets/event-finder.widget.dart';
import 'package:life/widgets/event-renderer.widget.dart';
import 'package:life/widgets/pill_button.dart';
import 'package:life/widgets/timeline-event.widget.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  EventsService eventsService = EventsService();
  var user = FirebaseAuth.instance.currentUser!;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _events;
  final DateTime _date = DateTime.now();
  final _confettiController =
      ConfettiController(duration: const Duration(seconds: 1));

  @override
  initState() {
    super.initState();
    _events = eventsService.eventsForDate(_date);
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _events,
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            var groupedEvents = groupByDate(snapshot.data!.docs);

            List<Widget> slivers = [];

            var search = Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: EventFinder(
                    placeholder: "Filter by event",
                    onSelect: (String value) {}));

            slivers.add(SliverToBoxAdapter(
              child: search,
            ));

            for (var element in groupedEvents.entries) {
              Widget header = SliverToBoxAdapter(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 32, 0, 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat.EEEE().format(element.key) + ", ",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 21),
                    ),
                    Text(DateFormat.MMMMd().format(element.key),
                        style: const TextStyle(fontSize: 21)),
                  ],
                ),
              ));

              Widget list = SliverList(
                  delegate: SliverChildListDelegate(element.value
                      .map((event) => TimelineEvent(
                          event: event, child: EventRenderer(event: event)))
                      .toList()));

              slivers.add(header);
              slivers.add(list);
            }

            /**
             * This is the padding at the end of the list to 
             * not have the add event button cover the last event
             * in the list.
             */
            slivers.add(const SliverToBoxAdapter(
                child: Padding(
              padding: EdgeInsets.only(bottom: 150),
            )));

            return SafeArea(
                child: Stack(alignment: Alignment.bottomCenter, children: [
              CustomScrollView(slivers: [
                HomeHeader(
                  user: user,
                ),
                ...slivers
              ]),
              IgnorePointer(
                child: Container(
                  height: MediaQuery.of(context).size.height * .2,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Colors.white.withOpacity(0.02),
                        Colors.white.withOpacity(1)
                      ])),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: ConfettiWidget(
                  blastDirectionality: BlastDirectionality.explosive,
                  blastDirection: -90 * 3.1415 / 180,
                  maxBlastForce: 50,
                  numberOfParticles: 30,
                  minimumSize: const Size(5, 5),
                  maximumSize: const Size(10, 10),
                  confettiController: _confettiController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: PillButton(
                    onPressed: () async {
                      _confettiController.play();
                      await Future.delayed(const Duration(seconds: 1));
                      Navigator.of(context).pushNamed(AddEventScreen.route);
                    },
                    label: "Add another event",
                    icon: Image.asset('assets/images/icons/confetti_color.png',
                        width: 32)),
              )
            ]));
          }),
    );
  }
}
