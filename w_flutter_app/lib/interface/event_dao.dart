import 'package:w_flutter_app/interface/planet.dart';

class EventDao {
  final int id;
  final String type;
  final String place;
  final String time;
  final String date;
  EventDao(this.id, this.type, this.place, this.time, this.date);

  EventDao.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        type = json['type'],
        place = json['place'],
        time = json['time'],
        date = json['date'];
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'place': place,
        'date': date,
        'time': time,
      };

  Planet convertToEvent() {
    return Planet(id, place, type, date, time, "",
        "https://pic4.zhimg.com/ba20c1881b132a2b1947bb4c29a");
  }
}
