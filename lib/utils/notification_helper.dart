import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:khm_app/models/notificationModel.dart';
import 'package:rxdart/subjects.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('notification_icon');

    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        final payload = details.payload;
        selectNotificationSubject.add(payload ?? 'empty payload');
      },
    );
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      NotificationModel data) async {
    var channelId = "1";
    var channelName = "Restaurant Recomendation";
    var channelDescription = "Restaurant Recomendation Notification Channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    // var titleNotification = "<b>Today Restaurant</b>";
    var titleNotification = data.title;
    var titleRestaurant = data.body;

    await flutterLocalNotificationsPlugin.show(
      data.id,
      titleNotification,
      titleRestaurant,
      platformChannelSpecifics,
      payload: 'notif',
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        print(payload);
      },
    );
  }
}
