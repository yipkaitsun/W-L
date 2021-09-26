import 'package:w_flutter_app/interface/event_detail.dart';

class Planet {
  final int id;
  final String location;
  final String type;
  final String date;
  final String time;
  final String description;
  final String icon;
  Planet(this.id, this.location, this.type, this.date, this.time,
      this.description, this.icon);

  Planet.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        location = json['location'],
        type = json['type'],
        date = json['date'],
        time = json['time'],
        description = json['description'],
        icon = json['icon'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'location': location,
        'date': date,
        'time': time,
        'description': description,
        'icon': icon,
      };

/*   EventDetail void ConvertToEventDetail() {
    return EventDetail(attendNumber, restTime, place, time, date)
  } */
}
