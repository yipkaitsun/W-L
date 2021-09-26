import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:w_flutter_app/interface/event_dao.dart';
import 'package:w_flutter_app/interface/planet.dart';
import 'package:w_flutter_app/submit_event.dart';
import 'package:w_flutter_app/widget/event_card.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as io;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  late ScrollController scrollController;

  List<Planet> _eventList = [];
  @override
  initState() {
    super.initState();
    _getEventList();
    io.io('http://223.18.74.197:5000');
    scrollController = ScrollController();
  }

  void _addEvent(Planet event) {
    setState(() {
      _eventList = List.from(_eventList)..add(event);
    });
  }

  Future<void> _getEventList() async {
    _eventList.clear();
    http.get(Uri.parse('http://223.18.74.197:5000/eventList')).then((result) {
      List<dynamic> events = jsonDecode(result.body);
      for (var event in events) {
        _addEvent((EventDao.fromJson(event).convertToEvent()));
      }
    }).then((value) => toTop());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _getEventList,
        child: Container(
            color: const Color(0xFF736AB7),
            child: CustomScrollView(
                controller: scrollController,
                slivers: <Widget>[
                  const SliverAppBar(
                    centerTitle: true,
                    title: Text("USERNAME"),
                    expandedHeight: 100,
                    floating: false,
                    pinned: true,
                    snap: false,
                  ),
                  SliverFixedExtentList(
                    itemExtent: 152.0,
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => EventRow(
                          event: _eventList[index],
                          getEventList: _getEventList),
                      childCount: _eventList.length,
                    ),
                  ),
                ])),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          toTop();
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

  void toTop() {
    scrollController.animateTo(50.0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
