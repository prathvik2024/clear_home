import 'message_model.dart';

class ChatModel {
  final String personName, image;
  String? lastMessage, time;
  int? pendingMessageCount;
  bool? status;

  ChatModel({required this.personName, required this.image, this.lastMessage, this.pendingMessageCount, this.time, this.status});
}
