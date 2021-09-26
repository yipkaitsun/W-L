class Attendance {
  final int id;
  final String isAccept;
  final String name;
  final String icon;
  final dynamic contents;
  Attendance(
    this.id,
    this.isAccept,
    this.name,
    this.icon,
    this.contents,
  );

  Attendance.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        isAccept = json['isAccept'],
        name = json['name'],
        contents = json['contents'],
        icon = json['icon'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'isAccept': isAccept,
        'name': name,
        'contents': contents,
        'icon': icon,
      };
}
