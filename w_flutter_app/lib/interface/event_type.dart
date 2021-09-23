class EventType {
  int id;
  String name;

  EventType(this.id, this.name);

  static List<EventType> getEventTypes() {
    return <EventType>[
      EventType(1, 'W'),
      EventType(2, 'L'),
    ];
  }
}
