class MyRoom {
  final String id;
  final String type;
  final String tag;
  final String startDateTime;

  MyRoom({
    required this.id,
    required this.type,
    required this.tag,
    required this.startDateTime,
  });

  factory MyRoom.fromJson(Map<String, dynamic> json) {
    return MyRoom(
      id: json['_id'],
      type: json['type'],
      tag: json['tag'],
      startDateTime: json['startDateTime'],
    );
  }
}
