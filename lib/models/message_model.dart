class MessageModel {
  String? toId, msg, read, fromId, sent, messageType;

  MessageModel({
    this.toId,
    this.msg,
    this.read,
    this.messageType,
    this.fromId,
    this.sent,
  });

  Map<String, dynamic> toMap() {
    return {
      'toId': this.toId,
      'msg': this.msg,
      'read': this.read,
      'messageType': this.messageType,
      'fromId': this.fromId,
      'sent': this.sent,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      toId: map['toId'],
      msg: map['msg'],
      read: map['read'],
      messageType: map['messageType'],
      fromId: map['fromId'],
      sent: map['sent'],
    );
  }

  @override
  String toString() {
    return 'MessageModel{toId: $toId, msg: $msg, read: $read, fromId: $fromId, sent: $sent, messageType: $messageType}';
  }
}

enum MessageType { text, image }
