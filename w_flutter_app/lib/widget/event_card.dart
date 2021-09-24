import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:w_flutter_app/event.dart';
import 'package:w_flutter_app/interface/planet.dart';

import '../submit_event.dart';

class EventRow extends StatelessWidget {
  late final Planet event;
  late final Future<void> Function() getEventList;
  EventRow({Key? key, required this.event, required this.getEventList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
                MaterialPageRoute(builder: (context) => EventPage(event.id)))
            .then((value) {
          if (value == true) {
            getEventList();
          }
        });
      },
      child: Container(
          height: 120.0,
          margin: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 21.0,
          ),
          child: Stack(
            children: <Widget>[
              eventCard,
              eventThumbnail,
            ],
          )),
    );
  }

  late final Container eventCard = Container(
      height: 124.0,
      margin: const EdgeInsets.only(left: 25.0),
      decoration: BoxDecoration(
        color: const Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: planetCardContent);

  late final Container eventThumbnail = Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      child: const CircleAvatar(
        radius: 50.0,
        backgroundImage: NetworkImage(
            "https://i.pinimg.com/736x/50/a9/d4/50a9d4bdc439c161fb8ea7244a060369.jpg"),
        backgroundColor: Colors.transparent,
      ));
  late final Container planetCardContent = Container(
    margin: const EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
    constraints: const BoxConstraints.expand(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(height: 5.0),
        Text(event.location, style: subHeaderTextStyle),
        Container(height: 10.0),
        Text(event.type, style: subHeaderTextStyle),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            height: 2.0,
            width: 18.0,
            color: const Color(0xff00c6ff)),
        Row(
          children: <Widget>[
            Image.asset("assets/ic_distance.png", height: 8.0),
            Container(width: 8.0),
            Text(
              event.date,
              style: regularTextStyle,
            ),
            Container(width: 24.0),
            Image.asset("assets/ic_gravity.png", height: 8.0),
            Container(width: 8.0),
            Text(
              event.time,
              style: regularTextStyle,
            ),
          ],
        ),
      ],
    ),
  );
}

const regularTextStyle = TextStyle(
    color: Color(0xffb6b2df), fontSize: 12.0, fontWeight: FontWeight.w400);
final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 12.0);
final headerTextStyle = regularTextStyle.copyWith(fontSize: 12.0);
