import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life/screens/home/home.helpers.dart';
import 'package:life/services/events.service.dart';
import 'package:life/widgets/event-renderer/event-renderer.widget.dart';
import 'package:life/widgets/screen-header.widget.dart';
import 'package:life/widgets/timeline-event/timeline-event.widget.dart';

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
  DateTime _date = DateTime.now();
  final formatter = DateFormat.MMMMEEEEd();

  @override
  initState() {
    super.initState();
    _events = eventsService.eventsForDate(_date);
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

            List<Widget> slivers = [
              SliverToBoxAdapter(child: ScreenHeader(user: user)),
            ];

            groupedEvents.entries.forEach((element) {
              Widget header = SliverToBoxAdapter(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 32, 0, 16),
                child: Text(formatter.format(element.key)),
              ));

              Widget list = SliverList(
                  delegate: SliverChildListDelegate(element.value
                      .map((event) => TimelineEvent(
                          event: event, child: EventRenderer(event: event)))
                      .toList()));

              slivers.add(header);
              slivers.add(list);
            });

            return SafeArea(child: CustomScrollView(slivers: slivers));
          }),
    );
  }
}
