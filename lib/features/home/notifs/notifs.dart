import 'package:bookmark_llm/features/home/notifs/local_notifs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Notifs {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    await LocalNotifs.init();

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User Granted Permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User Granted Provisional Permission");
    } else {
      print("User Declined Permission");
    }

    var fcmToken = await _messaging.getToken();
    print("FCM Token: $fcmToken");

    _messaging.onTokenRefresh.listen((token) => fcmToken = token);

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      // final android = message.notification?.android;

      final channel = LocalNotifs.channels["test"];

      if (notification != null) {
        LocalNotifs.showNotif(
          channel,
          id: message.hashCode,
          title: notification.title,
          body: notification.body,
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message.data);
    });
  }
}
