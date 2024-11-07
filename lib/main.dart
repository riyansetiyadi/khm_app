import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:khm_app/db/auth_repository.dart';
import 'package:khm_app/provider/address_provider.dart';
import 'package:khm_app/provider/auth_provider.dart';
import 'package:khm_app/provider/product_provider.dart';
import 'package:khm_app/provider/transaction_provider.dart';
import 'package:khm_app/routes/config.dart';
import 'package:khm_app/service/api_address.dart';
import 'package:khm_app/service/api_service.dart';
import 'package:khm_app/utils/fcm_helper.dart';
import 'package:khm_app/utils/notification_helper.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final FcmHelper fcmHelper = FcmHelper();

  String? selectedNotificationPayload;

  final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb &&
          Platform.isLinux
      ? null
      : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    selectedNotificationPayload =
        notificationAppLaunchDetails!.notificationResponse?.payload;
    if (selectedNotificationPayload != null) {
      print(selectedNotificationPayload);
    }
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  await fcmHelper.initFcm(flutterLocalNotificationsPlugin);

  runApp(const KhmApp());
}

class KhmApp extends StatefulWidget {
  const KhmApp({Key? key}) : super(key: key);

  @override
  State<KhmApp> createState() => _KhmAppState();
}

class _KhmAppState extends State<KhmApp> {
  late AuthProvider authProvider;
  late ProductProvider productProvider;
  late AddressProvider addressProvider;
  late TransactionProvider historyTransactionProvider;

  @override
  void initState() {
    super.initState();
    final authRepository = AuthRepository();
    final apiService = ApiService();
    final apiAddressService = ApiAddressService();

    authProvider = AuthProvider(
      authRepository,
      apiService,
    );

    productProvider = ProductProvider(
      apiService,
    );

    addressProvider = AddressProvider(
      apiAddressService,
    );

    historyTransactionProvider = TransactionProvider(
      apiService,
      authRepository,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => authProvider,
        ),
        ChangeNotifierProvider(
          create: (context) => productProvider,
        ),
        ChangeNotifierProvider(
          create: (context) => addressProvider,
        ),
        ChangeNotifierProvider(
          create: (context) => historyTransactionProvider,
        ),
      ],
      child: MaterialApp.router(routerConfig: router),
    );
  }
}
