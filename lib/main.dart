import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:khm_app/db/auth_repository.dart';
import 'package:khm_app/provider/address_provider.dart';
import 'package:khm_app/provider/auth_provider.dart';
import 'package:khm_app/provider/cart_provider.dart';
import 'package:khm_app/provider/chat_provider.dart';
import 'package:khm_app/provider/transaction_provider.dart';
import 'package:khm_app/provider/product_provider.dart';
import 'package:khm_app/service/api_service.dart';
import 'package:provider/provider.dart';
import 'package:khm_app/routes/config.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id_ID', null);

  runApp(const KhmApp());
}

class KhmApp extends StatefulWidget {
  const KhmApp({Key? key}) : super(key: key);

  @override
  State<KhmApp> createState() => _StoryAppState();
}

class _StoryAppState extends State<KhmApp> {
  late AuthProvider authProvider;
  late ProductProvider productProvider;
  late CartProvider cartProvider;
  late AddressProvider addressProvider;
  late TransactionProvider historyTransactionProvider;
  late ChatProvider chatProvider;

  @override
  void initState() {
    super.initState();
    final authRepository = AuthRepository();
    final apiService = ApiService();

    authProvider = AuthProvider(
      authRepository,
      apiService,
    );

    productProvider = ProductProvider(
      apiService,
    );
    cartProvider = CartProvider(
      apiService,
      authRepository,
    );

    addressProvider = AddressProvider(
      apiService,
    );
    historyTransactionProvider = TransactionProvider(
      apiService,
      authRepository,
    );
    chatProvider = ChatProvider(
      apiService,
      authRepository,
    );

    requestPermissions();
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
          create: (context) => cartProvider,
        ),
        ChangeNotifierProvider(
          create: (context) => addressProvider,
        ),
        ChangeNotifierProvider(
          create: (context) => historyTransactionProvider,
        ),
        ChangeNotifierProvider(
          create: (context) => chatProvider,
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }

  Future<void> requestPermissions() async {
    // Meminta izin penyimpanan
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      // Jika izin belum diberikan, minta izin
      if (await Permission.storage.request().isGranted) {
        print("Izin penyimpanan diberikan.");
      } else {
        print("Izin penyimpanan ditolak.");
      }
    } else {
      print("Izin penyimpanan sudah diberikan.");
    }
  }
}
