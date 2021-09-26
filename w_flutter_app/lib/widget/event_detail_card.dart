import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:w_flutter_app/interface/planet.dart';
import 'package:w_flutter_app/widget/dialog.dart';
import 'package:http/http.dart' as http;

class EventDetailCard extends StatefulWidget {
  const EventDetailCard({Key? key, required this.event}) : super(key: key);
  final Planet event;
  @override
  _State createState() => _State();
}

class _State extends State<EventDetailCard> {
  late int _id;
  @override
  initState() {
    _id = widget.event.id;
    super.initState();
  }

  void getEventDetail(_id) {
    http.get(
      Uri.parse('http://223.18.74.197:5000/attendance?id=$_id'),
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AttendanceDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Badge(
            position: BadgePosition.bottomEnd(bottom: 10, end: 10),
            badgeContent: Container(
              width: 18,
              height: 18,
              alignment: Alignment.center,
              child: Text(
                _id.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
            child: GestureDetector(
                onTap: () {
                  showAlertDialog(context);
                },
                child: Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 12.0),
                    height: 270,
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(children: <Widget>[
                            const Text(
                              "3:20 PM",
                              style: TextStyle(
                                  fontSize: 35.0, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const <Widget>[Text("Estimated Time")],
                            )
                          ]),
                          Row(children: <Widget>[
                            Flexible(
                              child: Container(
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF3366FF),
                                    Color(0xFF33E3FF),
                                  ],
                                )),
                                margin: const EdgeInsets.only(right: 5),
                                height: 5,
                              ),
                            ),
                            Flexible(
                              child: Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  height: 5,
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF33E3FF),
                                      Color(0xFF33FF5F),
                                    ],
                                  ))),
                            ),
                            Flexible(
                              child: Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  height: 5,
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF33FF5F),
                                      Color(0xFFCDFF33),
                                    ],
                                  ))),
                            ),
                            Flexible(
                              child: Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  height: 5,
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFCDFF33),
                                      Color(0xFFFFF833),
                                    ],
                                  ))),
                            ),
                            Flexible(
                              child: Container(
                                  height: 5,
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFFFF833),
                                      Color(0xFFFFC033),
                                    ],
                                  ))),
                            ),
                          ]),
                          Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: Row(children: <Widget>[
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  right: 20),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  border: Border.all(
                                                      width: 4,
                                                      color: Colors.white)),
                                              child: const Icon(
                                                Icons.access_time,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: const <Widget>[
                                                  Text("Rest Time",
                                                      style: TextStyle(
                                                        fontSize: 15.0,
                                                      )),
                                                  Text(
                                                    "30 min",
                                                    style: TextStyle(
                                                        fontSize: 17.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ])
                                          ])
                                    ])
                              ])),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 5.0,
                                  width: 3.0,
                                  color: Colors.black,
                                  margin: const EdgeInsets.only(
                                      top: 10.0,
                                      left: 14.0,
                                      right: 10.0,
                                      bottom: 5.0),
                                ),
                                Container(
                                  height: 5.0,
                                  width: 3.0,
                                  color: Colors.black,
                                  margin: const EdgeInsets.only(
                                      left: 14.0, right: 10.0, bottom: 5.0),
                                ),
                                Container(
                                  height: 5.0,
                                  width: 3.0,
                                  color: Colors.black,
                                  margin: const EdgeInsets.only(
                                      left: 14.0, right: 10.0, bottom: 10.0),
                                ),
                              ]),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          width: 4, color: Colors.white)),
                                  child: const Icon(
                                    Icons.access_time,
                                    color: Colors.black,
                                  ),
                                ),
                                Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: const <Widget>[
                                      Text("Dated Location",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          )),
                                      Text(
                                        "HGC Global Communications Limited",
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ]))
                              ]),
                        ])))));
  }
}
