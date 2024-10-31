import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:khm_app/firebase_options.dart';
import 'package:khm_app/models/notificationModel.dart';
import 'package:khm_app/utils/notification_helper.dart';

import 'package:firebase_core/firebase_core.dart';

class FcmHelper {
  static FcmHelper? _instance;

  FcmHelper._internal() {
    _instance = this;
  }

  factory FcmHelper() => _instance ?? FcmHelper._internal();

  Future<void> initFcm(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        final NotificationHelper notificationHelper = NotificationHelper();
        NotificationModel restaurant = NotificationModel(
          id: int.tryParse(message.data['id'].toString()) ?? 0,
          title: message.notification?.title,
          body: message.notification?.body,
          payload: 'payload',
        );
        await notificationHelper.showNotification(
          flutterLocalNotificationsPlugin,
          restaurant,
        );
      },
    );
  }
}
