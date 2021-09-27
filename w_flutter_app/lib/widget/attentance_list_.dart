import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:w_flutter_app/interface/attendance.dart';
import 'package:w_flutter_app/interface/attendance_dao.dart';
import 'package:http/http.dart' as http;

import 'chip.dart';

class AttendanceList extends StatefulWidget {
  const AttendanceList({Key? key, required this.title, required this.id})
      : super(key: key);
  final String title;
  final int id;
  @override
  State<AttendanceList> createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList> {
  late ScrollController scrollController;
  late int _id;
  List<Attendance> _attendanceList = [];

  @override
  initState() {
    _id = widget.id;
    super.initState();
    _getAttendanceList();
    scrollController = ScrollController();
  }

  void _addAttendance(Attendance attendance) {
    setState(() {
      _attendanceList = List.from(_attendanceList)..add(attendance);
    });
  }

  Future<void> _getAttendanceList() async {
    _attendanceList.clear();
    http
        .get(
      Uri.parse('http://223.18.74.197:5000/attendance?id=$_id'),
    )
        .then((result) {
      List<dynamic> attendances = jsonDecode(result.body);

      for (var attendance in attendances) {
        _addAttendance(
            (AttendanceDao.fromJson(attendance).convertToAttendance()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      onRefresh: _getAttendanceList,
      child: _attendanceList.isEmpty
          ? Image.asset("assets/loading.gif")
          : ListView.separated(
              itemCount: _attendanceList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  trailing: _attendanceList[index].isAccept == 'Y' ||
                          _attendanceList[index].isAccept == 'N'
                      ? _attendanceList[index].isAccept == 'Y'
                          ? chip('Yes', const Color(0XFF06d6a0))
                          : chip('No', const Color(0xFFEF476F))
                      : chip('Waiting', const Color(0xFFFFD166)),
                  leading: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(_attendanceList[index].icon),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(_attendanceList[index].name),
                  subtitle: Text(_attendanceList[index].contents),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
    ));
  }

  void toTop() {
    scrollController.animateTo(50.0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
