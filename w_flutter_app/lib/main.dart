import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:w_flutter_app/interface/event_dao.dart';
import 'package:w_flutter_app/interface/planet.dart';
import 'package:w_flutter_app/submit_event.dart';
import 'package:w_flutter_app/widget/event_card.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xFF749E9F, {
          50: Color.fromRGBO(79, 99, 103, .5),
          100: Color.fromRGBO(79, 99, 103, .2),
          200: Color.fromRGBO(79, 99, 103, .3),
          300: Color.fromRGBO(79, 99, 103, .1),
          400: Color.fromRGBO(79, 99, 103, .5),
          500: Color.fromRGBO(79, 99, 103, .5),
          600: Color.fromRGBO(79, 99, 103, .7),
          700: Color.fromRGBO(79, 99, 103, .8),
          800: Color.fromRGBO(79, 99, 103, .9),
          900: Color.fromRGBO(79, 99, 103, 5),
        }),
      ),
      home: const MyHomePage(
        title: 'W/L Notifier',
      ),
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
  Future<void> setAndroidNotification() async {
    try {
      AndroidNotificationChannel androidNotificationChannel =
          const AndroidNotificationChannel(
              "high_importance_channel", "Notification body", "Notification",
              importance: Importance.high);

      await FlutterLocalNotificationsPlugin()
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(androidNotificationChannel);
    } catch (e) {
      // Handle error...
      // 处理代码执行错误...
    }
  }

  Future<void> setForegroundNotificationPresentationOptions() async {
    try {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  initState() {
    super.initState();
    _getEventList();

    setAndroidNotification().then((value) async {
      setForegroundNotificationPresentationOptions();
    }).then((value) {
      FirebaseMessaging.onMessage.listen((message) async {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        if (notification != null && android != null) {
          await FlutterLocalNotificationsPlugin().show(
              notification.hashCode,
              notification.title,
              notification.body,
              const NotificationDetails(
                android: AndroidNotificationDetails("high_importance_channel",
                    "Notification body", "Notification",
                    icon: 'launch_background',
                    priority: Priority.high,
                    importance: Importance.high),
              ));
        }
      });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _getEventList();
    });
    //io.io('http://223.18.74.197:5000');
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
            color: const Color(0xFFF8F8F8),
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
