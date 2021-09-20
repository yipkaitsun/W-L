import 'package:flutter/widgets.dart';

class Event {
  final String title;
  final String subtitle;
  final IconData icon;
  Event(this.title, this.subtitle,this.icon);

  Event.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        subtitle = json['subtitle'],
        icon=json['icon'];

  Map<String, dynamic> toJson() =>
    {
      'title': title,
      'subtitle': subtitle,
      'icon':icon
    };
}


