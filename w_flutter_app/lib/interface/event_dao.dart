import 'package:w_flutter_app/interface/planet.dart';

class EventDao {
  final int id;
  final String icon;
  final int attendNumber;
  final String type;
  final String place;
  final String time;
  final String date;
  EventDao(this.id, this.type, this.place, this.time, this.date, this.icon,
      this.attendNumber);

  EventDao.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        type = json['type'],
        place = json['place'],
        time = json['time'],
        date = json['date'],
        icon = json['icon'],
        attendNumber = json['attendNumber'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'place': place,
        'date': date,
        'time': time,
        'icon': icon,
        'attendNum': attendNumber,
      };

  Planet convertToEvent() {
    return Planet(id, place, type, date, time, "", icon);
  }
}
