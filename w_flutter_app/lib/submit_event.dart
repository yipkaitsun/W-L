import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class SubmitEventPage extends StatelessWidget {
  const SubmitEventPage({Key? key, required this.setEventList})
      : super(key: key);
  final ValueChanged<String> setEventList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Event'),
      ),
      body: FormSubmit(setEventList: setEventList),
    );
  }
}

class FormSubmit extends StatefulWidget {
  final ValueChanged<String> setEventList;
  const FormSubmit({
    Key? key,
    required this.setEventList,
  }) : super(key: key);

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
    _eventType = "wwwww";
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
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                widget.setEventList("asd");
              }
            },
            child: const Text('Submit'),
          ),
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
      items: <String>['wwwww', 'LLLL']
          .map<DropdownMenuItem<String>>((String value) {
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
