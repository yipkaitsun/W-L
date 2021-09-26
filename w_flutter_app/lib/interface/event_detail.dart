class EventDetail {
  final int attendNumber;
  final String restTime;
  final String place;
  final String time;
  final String date;

  EventDetail(
      this.attendNumber, this.restTime, this.place, this.time, this.date);

  EventDetail.fromJson(Map<String, dynamic> json)
      : attendNumber = json['id'],
        restTime = json['type'],
        place = json['place'],
        time = json['time'],
        date = json['date'];
  Map<String, dynamic> toJson() => {
        'attendNumber': attendNumber,
        'restTime': restTime,
        'place': place,
        'date': date,
        'time': time,
      };
}
