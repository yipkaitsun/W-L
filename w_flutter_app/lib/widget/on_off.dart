import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OnOffWidget extends StatelessWidget {
  final bool isSwitched;
  final void Function(bool isOn, bool isValid) setDialogState;
  const OnOffWidget(
      {Key? key, required this.isSwitched, required this.setDialogState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isSwitched,
      onChanged: (isSwitched) {
        setDialogState(isSwitched, isSwitched ? true : false);
      },
      activeTrackColor: Colors.lightGreenAccent,
      activeColor: Colors.green,
    );
  }
}
