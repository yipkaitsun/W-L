import 'package:flutter/material.dart';
import 'package:w_flutter_app/widget/attentance_list_.dart';
import 'package:w_flutter_app/widget/event_detail_card.dart';

import 'interface/planet.dart';

class EventPage extends StatelessWidget {
  final Planet event;
  const EventPage({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xFFC0D6DF),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(270.0),
              child: EventDetailCard(event: event),
            )),
        body: AttendanceList(id: event.id, title: 'AttendanceList'));
  }
}
