// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:khm_app/bloc/login/login_bloc.dart';
// import 'package:khm_app/bloc/login/login_state.dart';
// import 'package:khm_app/screens/register_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'screens/login_screen.dart';
// import 'screens/home_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final prefs = await SharedPreferences.getInstance();
//   final String? token = prefs.getString('auth_token');

//   runApp(MyApp(isLoggedIn: token != null));
// }

// class MyApp extends StatelessWidget {
//   final bool isLoggedIn;

//   MyApp({required this.isLoggedIn});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter BLoC Login',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home:
//             // RegisterScreen()
//             BlocProvider(
//           create: (context) => LoginBloc(),
//           child: Scaffold(
//             appBar: AppBar(
//               title: const Text('Text Change'),
//             ),
//             body: BlocConsumer<LoginBloc, LoginState>(
//               listener: (context, state) {},
//               builder: (context, state) {
//                 return isLoggedIn ? HomeScreen() : LoginScreen();
//               },
//             ),
//           ),
//         ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:khm_app/db/auth_repository.dart';
import 'package:khm_app/provider/auth_provider.dart';
import 'package:khm_app/routes/page_manager.dart';
import 'package:khm_app/routes/route_information_parser.dart';
import 'package:khm_app/routes/router_delegate.dart';
import 'package:khm_app/service/api_service.dart';
import 'package:provider/provider.dart';

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
        ],
        child: MaterialApp(
          title: 'Husada Mulia',
          home: Router(
            routerDelegate: myRouterDelegate,
            routeInformationParser: routeInformationParser,
            // backButtonDispatcher: RootBackButtonDispatcher(),
          ),
        ));
  }
}
