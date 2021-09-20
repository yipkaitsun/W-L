import 'package:flutter/material.dart';
import 'package:w_flutter_app/submit_event.dart';
import 'interface/event.dart';

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
      subtitle: Text(event.subtitle),
      leading: Icon(
        event.icon,
        color: Colors.blue,
      ),
    );
  }

  List<Widget> _eventlist = <Widget>[];
  @override
  initState() {
    super.initState();
    _eventlist = [];
  }

  void _addEvent(Event event) {
    setState(() {
      _eventlist = List.from(_eventlist)..add(convertDto(event));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        child: ListView(
          children: _eventlist,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SubmitEventPage()))
              .then((value) => _addEvent(value));
          //_addEvent(Event("123", '234', Icons.event_available));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
