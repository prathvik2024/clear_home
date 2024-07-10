class ChatModel {
  final String personName, image;
  String? time, id, lastActiveTime, pushToken;
  bool? isOnline;

  ChatModel({required this.personName, this.id, required this.image, this.pushToken, this.lastActiveTime, this.time, this.isOnline});

  Map<String, dynamic> toMap() {
    return {
      'personName': personName,
      'id': id,
      'image': image,
      'lastActiveTime': lastActiveTime,
      'time': time,
      'pushToken': pushToken,
      'isOnline': isOnline,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      personName: map['personName'],
      id: map['id'],
      image: map['image'],
      pushToken: map['pushToken'],
      lastActiveTime: map['lastActiveTime'],
      time: map['time'],
      isOnline: map['isOnline'],
    );
  }
}
