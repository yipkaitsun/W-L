import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:http/http.dart' as http;

class EventPage extends StatelessWidget {
  const EventPage(int id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      height: 380,
      width: double.infinity,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Row(children: <Widget>[
            const SizedBox(
              height: 300,
              child: Expanded(
                child: Text("3:20 PM"),
              ),
            ),
            const Spacer(),
            SizedBox(height: 300, child: Text("佐敦彌敦道382號")),
          ])),
    ));
  }
}

class FormSubmit extends StatefulWidget {
  const FormSubmit({Key? key}) : super(key: key);

  @override
  State<FormSubmit> createState() => _FormSubmitState();
}

class _FormSubmitState extends State<FormSubmit> {
  final _formKey = GlobalKey<FormState>();
  late String _eventType;
  late DateTime _dateTime;
  late String _place;

  @override
  void initState() {
    super.initState();
    _eventType = "W";
    _dateTime = DateTime(1699);
  }

  void _setEventType(String event) {
    setState(() {
      _eventType = event;
    });
  }

  void _setDateTime(DateTime dateTime) {
    setState(() {
      _dateTime = dateTime;
    });
  }

  void _setPlace(String place) {
    setState(() {
      _place = place;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DropDownMenu(eventType: _eventType, setEventType: _setEventType),
          TextFormField(
              decoration: const InputDecoration(
                  labelText: "地點",
                  hintText: "想約邊到?",
                  prefixIcon: Icon(Icons.place)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '邊到又唔撚講';
                }
                return null;
              },
              onSaved: (value) => _setPlace(value!)),
          BasicDateTimeField(
            dateTime: _dateTime,
            setDateTime: _setDateTime,
          ),
          Expanded(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Map<String, String> requestHeaders = {
                      'Content-type': 'application/json',
                      'Accept': 'application/json',
                    };

                    http
                        .post(
                      Uri.parse('http://223.18.74.197:5000/event'),
                      headers: requestHeaders,
                      body: jsonEncode(<String, dynamic>{
                        'time': _dateTime.toString(),
                        'place': _place,
                        'type': _eventType
                      }),
                    )
                        .then((isSuccess) {
                      Navigator.pop(context, isSuccess);
                    });
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ))
        ],
      ),
    );
  }
}

// Drop Down Menu

class DropDownMenu extends StatelessWidget {
  final ValueChanged<String> setEventType;
  final String eventType;
  const DropDownMenu(
      {Key? key, required this.setEventType, required this.eventType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: eventType,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      decoration: const InputDecoration(
        filled: true,
        prefixIcon: Icon(Icons.question_answer),
        labelText: '約WHAT??',
      ),
      onChanged: (value) => {setEventType(value!)},
      onSaved: (String? newValue) {
        setEventType(newValue!);
      },
      items: <String>['W', 'L'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

// Time Widget

class BasicDateTimeField extends StatelessWidget {
  final ValueChanged<DateTime> setDateTime;
  final DateTime dateTime;
  final format = DateFormat("yyyy-MM-dd HH:mm");
  BasicDateTimeField(
      {Key? key, required this.setDateTime, required this.dateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        decoration: const InputDecoration(
            labelText: "時間",
            hintText: "閪時間?",
            prefixIcon: Icon(Icons.timelapse)),
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
        onSaved: (DateTime? newValue) {
          setDateTime(newValue!);
        },
      ),
    ]);
  }
}
