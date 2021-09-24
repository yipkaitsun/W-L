import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:w_flutter_app/interface/event_dao.dart';
import 'package:w_flutter_app/interface/planet.dart';
import 'package:w_flutter_app/submit_event.dart';
import 'package:w_flutter_app/widget/event_card.dart';
import 'interface/event.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'W/L Notifier'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ListTile convertDto(Event event) {
    return ListTile(
      title: Text(
        event.title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
      ),
      onLongPress: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SubmitEventPage())).then((value) {
          if (value == true) {
            _getEventList();
          }
        });
      },
      subtitle: Text(event.subtitle),
      leading: Icon(
        event.icon,
        color: Colors.blue,
      ),
    );
  }

  List<Planet> _planetList = [];
  //List<Event> _eventList = [];
  @override
  initState() {
    super.initState();
    _getEventList();
    IO.io('http://223.18.74.197:5000');
  }

  void _addEvent(Planet event) {
    setState(() {
      _planetList = List.from(_planetList)..add(event);
    });
  }

  Future<void> _getEventList() async {
    //_eventList.clear();
    _planetList.clear();
    var result =
        (await http.get(Uri.parse('http://223.18.74.197:5000/eventList')));
    List<dynamic> events = jsonDecode(result.body);

    for (var event in events) {
      _addEvent((EventDao.fromJson(event).convertToEvent()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _getEventList,
        child: Container(
            color: const Color(0xFF736AB7),
            child: CustomScrollView(slivers: <Widget>[
              SliverAppBar(
                centerTitle: true,
                /*  flexibleSpace: Stack(
                  children: <Widget>[
                    Positioned.fill(
                        child: Image.network(
                      "https://st4.depositphotos.com/11486368/25799/v/950/depositphotos_257990538-stock-illustration-chill-out-open-mic-party.jpg",
                      fit: BoxFit.cover,
                    ))
                  ],
                ), */
                title: Text("USERNAME"),
                expandedHeight: 230.0,
                floating: false,
                pinned: true,
                snap: false,
              ),
              SliverFixedExtentList(
                itemExtent: 152.0,
                delegate: SliverChildBuilderDelegate(
                  (context, index) => EventRow(
                      event: _planetList[index], getEventList: _getEventList),
                  childCount: _planetList.length,
                ),
              ),
            ])),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SubmitEventPage())).then((value) {
            if (value == true) {
              _getEventList();
            }
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
