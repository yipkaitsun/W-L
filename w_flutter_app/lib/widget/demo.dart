import 'package:flutter/material.dart';

class EventDetailCard extends StatefulWidget {
  const EventDetailCard({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<EventDetailCard> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Switch(
        value: isSwitched,
        onChanged: (value) {
          setState(() {
            isSwitched = value;
          });
        },
        activeTrackColor: Colors.lightGreenAccent,
        activeColor: Colors.green,
      ),
    );
  }
}
