import 'package:clear_home/constants/helper.dart';
import 'package:clear_home/models/chat_model.dart';
import 'package:clear_home/routes/routes.dart';
import 'package:clear_home/screens/chat_module/chat_details_screen.dart';
import 'package:clear_home/utils/firebase_provider.dart';
import 'package:clear_home/utils/push_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseProvider.serverKey = await PushNotificationService.getServerAccessToken();

  FirebaseMessaging.onMessageOpenedApp.listen((event) async {
    if (event.data["userId"] != null) {
      final snapshot = await FirebaseProvider.getUserById(event.data["userId"]);
      final data = Map<String, dynamic>.from(snapshot.data() ?? {});
      ChatModel chatUser = ChatModel.fromMap(data);
      Helper.navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => ChatDetailsScreen(chatModel: chatUser)));
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clear Home',
      navigatorKey: Helper.navigatorKey,
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.splash,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
