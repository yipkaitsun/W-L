import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:w_flutter_app/widget/button.dart';
import 'package:http/http.dart' as http;
import 'on_off.dart';

class AttendanceDialog extends StatefulWidget {
  const AttendanceDialog({
    Key? key,
  }) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<AttendanceDialog> {
  final TextEditingController _reasonController = TextEditingController();
  bool _switchVal = false;
  bool _validVal = false;

  void submitAttendance() {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    _switchVal
        ? http.post(Uri.parse('http://223.18.74.197:5000/event'),
            headers: requestHeaders, body: "asdasd")
        : _validVal
            ? http.post(Uri.parse('http://223.18.74.197:5000/event'),
                headers: requestHeaders, body: "asdasd")
            : () {};
  }

  void setDialogState(bool isSwitch, bool isValid) {
    setState(() {
      _switchVal = isSwitch;
      _validVal =
          isSwitch ? isValid : (isValid || _reasonController.text.trim() != '');
    });
  }

  @override
  void initState() {
    super.initState();
    _reasonController.addListener(() {
      _reasonController.text.trim() == ''
          ? setState(() {
              _validVal = false;
            })
          : setState(() {
              _validVal = true;
            });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      child: Column(children: <Widget>[
        const Center(child: Text('去唔去?')),
        OnOffWidget(isSwitched: _switchVal, setDialogState: setDialogState),
        SizedBox(
          height: 60.0,
          child: Visibility(
              visible: !_switchVal,
              child: TextFormField(
                controller: _reasonController,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  labelText: '點解啊:',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )),
        ),
        SizedBox(child: Button(isEnabled: _validVal), height: 48)
      ]),
      padding: const EdgeInsets.all(20.0),
      width: 250,
      height: 216,
    ));
  }
}
