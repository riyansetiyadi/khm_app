import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:khm_app/db/auth_kosmetik_repository.dart';
import 'package:khm_app/db/auth_pasien_repository.dart';
import 'package:khm_app/provider/address_provider.dart';
import 'package:khm_app/provider/auth_kosmetik_provider.dart';
import 'package:khm_app/provider/auth_pasien_provider.dart';
import 'package:khm_app/provider/cart_provider.dart';
import 'package:khm_app/provider/product_provider.dart';
import 'package:khm_app/provider/transaction_provider.dart';
import 'package:khm_app/routes/config.dart';
import 'package:khm_app/service/api_address_service.dart';
import 'package:khm_app/service/api_kosmetik_service.dart';
import 'package:khm_app/service/api_pasien_service.dart';
import 'package:khm_app/utils/fcm_helper.dart';
import 'package:khm_app/utils/notification_helper.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id_ID', null);

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
  late AuthKosmetikProvider authKosmetikProvider;
  late ProductProvider productProvider;
  late AddressProvider addressProvider;
  late TransactionProvider historyTransactionProvider;
  late CartProvider cartProvider;

  late AuthPasienProvider authPasienProvider;

  @override
  void initState() {
    super.initState();
    final authKosmetikRepository = AuthKosmetikRepository();
    final apiKosmetikService = ApiKosmetikService();

    final apiAddressService = ApiAddressService();

    final authPasienRepository = AuthPasienRepository();
    final apiPasienService = ApiPasienService();

    authKosmetikProvider = AuthKosmetikProvider(
      authKosmetikRepository,
      apiKosmetikService,
    );

    productProvider = ProductProvider(
      apiKosmetikService,
    );

    addressProvider = AddressProvider(
      apiAddressService,
    );

    historyTransactionProvider = TransactionProvider(
      apiKosmetikService,
      authKosmetikRepository,
    );

    cartProvider = CartProvider(
      apiKosmetikService,
      authKosmetikRepository,
    );

    authPasienProvider = AuthPasienProvider(
      authPasienRepository,
      apiPasienService,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => authKosmetikProvider,
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
        ChangeNotifierProvider(
          create: (context) => cartProvider,
        ),
        ChangeNotifierProvider(
          create: (context) => authPasienProvider,
        ),
      ],
      child: MaterialApp.router(routerConfig: router),
    );
  }
}
