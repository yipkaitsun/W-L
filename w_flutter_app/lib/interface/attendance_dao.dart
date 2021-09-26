import 'package:w_flutter_app/interface/attendance.dart';
import 'package:w_flutter_app/interface/planet.dart';

class AttendanceDao {
  final int id;
  final String isAccept;
  final String name;
  final String icon;
  final dynamic contents;
  AttendanceDao(this.id, this.isAccept, this.name, this.icon, this.contents);

  AttendanceDao.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        isAccept = json['isAccept'],
        name = json['name'],
        icon = json['icon'],
        contents = (json['contents'] == null) ? '' : json['contents'];
  Map<String, dynamic> toJson() => {
        'id': id,
        'isAccept': isAccept,
        'name': name,
        'icon': contents,
        'contents': icon,
      };

  Attendance convertToAttendance() {
    return Attendance(id, isAccept, name, icon, contents);
  }
}
