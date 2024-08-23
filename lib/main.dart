import 'package:flutter/material.dart';
import 'package:khm_app/db/auth_repository.dart';
import 'package:khm_app/provider/address_provider.dart';
import 'package:khm_app/provider/auth_provider.dart';
import 'package:khm_app/provider/cart_provider.dart';
import 'package:khm_app/provider/transaction_provider.dart';
import 'package:khm_app/provider/product_provider.dart';
import 'package:khm_app/routes/page_manager.dart';
import 'package:khm_app/routes/route_information_parser.dart';
import 'package:khm_app/routes/router_delegate.dart';
import 'package:khm_app/service/api_service.dart';
import 'package:provider/provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const KhmApp());
}

class KhmApp extends StatefulWidget {
  const KhmApp({Key? key}) : super(key: key);

  @override
  State<KhmApp> createState() => _StoryAppState();
}

class _StoryAppState extends State<KhmApp> {
  late MyRouterDelegate myRouterDelegate;
  late AuthProvider authProvider;
  late ProductProvider productProvider;
  late CartProvider cartProvider;
  late AddressProvider addressProvider;
  late TransactionProvider historyTransactionProvider;
  late AppRouteInformationParser routeInformationParser;

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

    myRouterDelegate = MyRouterDelegate(authRepository);
    routeInformationParser = AppRouteInformationParser();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => PageManager(),
          ),
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
        ],
        child: MaterialApp(
          title: 'Husada Mulia',
          home: Router(
            routerDelegate: myRouterDelegate,
            routeInformationParser: routeInformationParser,
            backButtonDispatcher: RootBackButtonDispatcher(),
          ),
          locale: Locale('id', 'ID'),
          supportedLocales: [
            const Locale('id', 'ID'),
          ],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ));
  }
}
