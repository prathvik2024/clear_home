import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class PushNotificationService {
  static Future<String> getServerAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "clean-home-bbddd",
      "private_key_id": "90c1dd531f1ca476ddb8a1cde78c92a58a9051a7",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDEv3/CAO6vL8Go\npgE2o+7gh8XC9UQFiRTlTyC536JiXo3ljtWy98uMvLonYqHofpj1msaC8cnfcogz\nITG6QQiwBqCMbkqU21F3xIUVi1AqmkppRsxdrZwJLy5qKOyCWu4uHKrUTRo+OTAZ\nadTT8zzOuvt5DEi0IDCUm5lZ3L1MX6gG3X3RfD9sNkswpUyq/N0A68tJqLCR4sLT\nFJOhNY6ny20+0jB+z9t5JaIU2+/+WZD0Enhn/kCM2FAqOkMl/D4/shOwZa2cZLZ/\nq2rqr085jAEhGomwcSjdCzzcSUo+fr2AAK9BBO27tQoJ/QID4cAT87uYeru/XWPr\nHbkypWybAgMBAAECggEABsND+hSqZXbkRUL8Ow5aHbOOfRAZEjvR+dNK9ouMMn7F\ncqwlndoVFdWQg5gmMHontEWAufFvDFz1VFrFDsOqJAJxNyEOeX+rILX/5CukZxp7\nODZY6p1oelE/uFC14wG5aVUrvpf0DgTYklwlObAFGXerQRXGmW/g6LLFaQ5hqs+N\nfHlARzr15J67frJIwDz5ebnOQ312NAcQv4IJ6/FiactntjMh8TUEEyhXHj05sI5X\no4E8ABnqWocBaaULJ0YG34ErhLRhBQd2xKi3P5zisCcZgnu0yHrlA4WX98ZnvmyN\n4maiFtLsYS9LJNrxy7bDWMz6M1gMbSknC0UygWjLiQKBgQDm5gOX0fPbJ3l48xw9\nV5R4YcXOFnBWiNNNpfKQ1WGGWd+vKdLV8qX02X3512KlxKyZv9pzK0rnFc2FGmwO\naZkvIsLKXJfUKh1dLZLx9JtqpCLd/iZCa13DoFYLX5MtoirZIB9Ary/cK2nanZbM\nlqRvKEwrtiOhjMgF9G+jRgODYwKBgQDaIxDoqmx314yZF275f6/qvPkvJ1GixIeD\n7QwcnaJPQkMeA+WBLaTTHUE772S6kJ5kYpgavUaZUV11leyFEM1+hoI6gD6nvlVH\nEoETRVVKdaqnfUvF/FW2LOuCpdqeqvlvFICz6Bx5j1bL1c7V4HioA9QkBD1FBvzM\ns4lWZiojaQKBgQCQ+3bgGp3zSzsT/hsKTXbVjBcHS8GoJGwBwqSn2sRM9xvkQe+4\nFY+tSe+3NE4l5nO2auhBDrsOlPsii6+z8QyVs076f996AiPEATzWnpAECyI1oELn\ny8DpeEDvDUk+Cyi6g1f8ZsQ3jC8AbZllx2Viwrvpaom/A8YJLy32KJ1GHwKBgQDS\nulNoYNLeRxXlAvVLA+Ye36Xdvp8nnbHIaaRstH+LD9kk0uDQlRaId9eAHfjyHilV\nksWb90OPc0HVCRtvRNcvpqOB/kgI5l8dhKu6wRzvDJLqsKkVv3nRvr1Y/f4fj83d\nWDIpGk7/w9A2o/rnNK16qhAzJwFFgMWQvtQq6hFFGQKBgGQ+jFFbGQPQPQgrxXOM\ndUuuhAbPpUa5q04s+XK7srfu2ug1V7m0Tm+jUBIPxc1qkjBG+7TyK3N4rr1xtQge\nF9gTBOMPMB3hRFARBBhmgf8gY4p+Z+0tDXKnlAGPwoKM55lOlkxw/JlHWaeEFTlK\nbe7gnofp8SzWvwAg4ao1rbUt\n-----END PRIVATE KEY-----\n",
      "client_email": "cleanhome@clean-home-bbddd.iam.gserviceaccount.com",
      "client_id": "114805948398448162985",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/cleanhome%40clean-home-bbddd.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/firebase.messaging",
      "https://www.googleapis.com/auth/firebase.database",
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    // getAccess Token
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes, client);
    client.close();
    print("log server access token: ${credentials.accessToken.data}");
    return credentials.accessToken.data;
  }

  static sendNotification({
    required String userAuthId,
    required String serverToken,
    required String deviceToken,
    required String message,
  }) async {
    String endpointFCM = "https://fcm.googleapis.com/v1/projects/clean-home-bbddd/messages:send";
    final Map<String, dynamic> bodyMessage = {
      'message': {
        'token': deviceToken,
        'notification': {
          'title': 'Clean Home',
          'body': message,
        },
        'data': {"userId": userAuthId}
      }
    };

    final http.Response response = await http.post(Uri.parse(endpointFCM),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $serverToken',
        },
        body: jsonEncode(bodyMessage));

    print(response.statusCode);
    if (response.statusCode == 200) {
      print("log Sent Notification successfully");
    } else {
      print("log Failed Notification");
    }
  }
}
