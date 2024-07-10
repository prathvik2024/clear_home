import 'dart:io';

import 'package:clear_home/models/chat_model.dart';
import 'package:clear_home/models/message_model.dart';
import 'package:clear_home/utils/push_notification_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants/helper.dart';
import '../screens/chat_module/chat_details_screen.dart';

class FirebaseProvider {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firebaseStore = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;
  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;
  static String serverKey = "";

  static User get user => firebaseAuth.currentUser!;

  static Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  static Future<bool> userExists() async {
    return (await firebaseStore.collection("users").doc(firebaseAuth.currentUser!.uid).get()).exists;
  }

  static Future<void> createUser() async {
    final ChatModel userChatModel = ChatModel(
        personName: user.displayName.toString(),
        image: user.photoURL.toString(),
        id: user.uid,
        isOnline: true,
        pushToken: "",
        time: DateTime.now().hour.toString(),
        lastActiveTime: DateTime.now().hour.toString());

    return await firebaseStore.collection("users").doc(user.uid).set(userChatModel.toMap());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getChatAll() {
    return FirebaseProvider.firebaseStore.collection("users").where("id", isNotEqualTo: user.uid).snapshots();
  }

  static String getConversationId(String id) => user.uid.hashCode <= id.hashCode ? '${user.uid}_$id' : '${id}_${user.uid}';

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(ChatModel chatModel) {
    return firebaseStore.collection("chats/${getConversationId(chatModel.id ?? "")}/messages/").snapshots();
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> getUserById(String id) {
    return firebaseStore.collection("users").doc(id).get();
  }

  static Future<void> sendMessage(ChatModel chatUser, String msg, String type) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final MessageModel messageMode = MessageModel(messageType: type, fromId: user.uid, toId: chatUser.id, msg: msg, read: "", sent: time);
    await firebaseStore.collection("chats/${getConversationId(chatUser.id ?? "")}/messages/").doc(time).set(messageMode.toMap());
    await PushNotificationService.sendNotification(serverToken: serverKey, userAuthId: user.uid, deviceToken: chatUser.pushToken ?? "", message: msg);
  }

  static Future<void> getMessagingToken(bool isOnline) async {
    await fMessaging.requestPermission();
    await fMessaging.getToken().then((t) async {
      if (t != null) {
        await updateUserStatus(isOnline: isOnline, token: t);
      }
    });
  }

  static Future<void> updateMessageStatus(MessageModel message) async {
    await firebaseStore
        .collection("chats/${getConversationId(message.fromId ?? "")}/messages/")
        .doc(message.sent)
        .update({"read": DateTime.now().millisecondsSinceEpoch.toString()});
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessages(ChatModel chatModel) {
    return firebaseStore
        .collection("chats/${getConversationId(chatModel.id ?? "")}/messages/")
        .orderBy("sent", descending: true)
        .limit(1)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUnreadMessageCount(ChatModel chatModel) {
    return firebaseStore.collection("chats/${getConversationId(chatModel.id ?? "")}/messages/").where("read", isEqualTo: "").snapshots();
  }

  static Future<void> sendChatImage(ChatModel chatUser, File file) async {
    final ext = file.path.split(".").last;
    final ref = storage.ref().child("images/${getConversationId(chatUser.id ?? "")}/${DateTime.now().millisecondsSinceEpoch}.$ext");
    await ref.putFile(file, SettableMetadata(contentType: "images/$ext")).then((p0) {
      print("Data transaffred: ${p0.bytesTransferred / 1000} KB");
    });
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(chatUser, imageUrl, "image");
  }

  static Future<void> updateUserStatus({required bool isOnline, required String token}) async {
    await firebaseStore
        .collection("users")
        .doc(user.uid)
        .update({"isOnline": isOnline, "lastActiveTime": DateTime.now().millisecondsSinceEpoch.toString(), "pushToken": token});
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(ChatModel chatUser) {
    return firebaseStore.collection("users").where("id", isEqualTo: chatUser.id).snapshots();
  }

  static Future<void> backgroundHandler(RemoteMessage message) async {
    print("Handling background message: ${message}");
    final snapshot = await FirebaseProvider.getUserById(message.data["userId"]);
    final data = Map<String, dynamic>.from(snapshot.data() ?? {});
    ChatModel chatUser = ChatModel.fromMap(data);
    await Navigator.push(Helper.navigatorKey.currentState!.context, MaterialPageRoute(builder: (context) => ChatDetailsScreen(chatModel: chatUser)));
  }
}
