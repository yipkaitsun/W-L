import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Button extends StatelessWidget {
  final bool isEnabled;
  const Button({Key? key, required this.isEnabled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 1,
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: isEnabled ? Colors.red : Colors.teal,
        ),
        onPressed: () {},
        child: const Text('Submitt'),
      ),
    );
  }
}
