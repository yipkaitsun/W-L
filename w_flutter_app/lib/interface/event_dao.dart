import 'package:flutter/material.dart';
import 'package:w_flutter_app/interface/event.dart';

class EventDao {
  final int id;
  final String type;
  final String place;
  final String time;
  EventDao(this.id, this.type, this.place, this.time);

  EventDao.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        type = json['type'],
        place = json['place'],
        time = json['time'];
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'place': place,
        'date': time,
      };

  Event ConvertToEvent() {
    if (type == 'W') {
      return Event(place, time, Icons.ac_unit_outlined);
    } else
      return Event(place, time, Icons.zoom_out_outlined);
  }
}
