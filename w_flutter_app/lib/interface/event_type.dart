
class EventType {
  int id;
  String name;

  EventType(this.id, this.name);

  static List<EventType> getEventTypes() {
    return <EventType>[
      EventType(1, 'wwwww'),
      EventType(2, 'LLLLL'),
    ];
  }
}
