import 'package:flutter/material.dart';
import 'package:khm_app/db/auth_repository.dart';
import 'package:khm_app/provider/cart_provider.dart';
import 'package:khm_app/provider/history_transaction_provider.dart';
import 'package:khm_app/provider/product_provider.dart';
import 'package:khm_app/screens/detail_product_screen.dart';
import 'package:khm_app/screens/home_screen.dart';
import 'package:khm_app/screens/login_screen.dart';
import 'package:khm_app/screens/profil_screen.dart';
import 'package:khm_app/screens/cart_screen.dart';
import 'package:khm_app/screens/register_screen.dart';
import 'package:khm_app/screens/addroom_screen.dart';
import 'package:khm_app/screens/chat_screen.dart';
import 'package:khm_app/screens/shop_screen.dart';
import 'package:khm_app/screens/riwayat_screen.dart';
import 'package:khm_app/screens/registerkonsul_screen.dart';
import 'package:khm_app/screens/registeraddress_screen.dart';
import 'package:khm_app/screens/checkout_screen.dart';
import 'package:khm_app/screens/setting_screen.dart';
import 'package:khm_app/screens/splash_screen.dart';
import 'package:khm_app/utils/enum_app_page.dart';
import 'package:khm_app/utils/list_auth_page.dart';
import 'package:khm_app/utils/list_auth_required_page.dart';
import 'package:khm_app/utils/list_bottom_nav_page.dart';
import 'package:provider/provider.dart';

class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthRepository authRepository;

  MyRouterDelegate(
    this.authRepository,
  ) : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _init() async {
    var result = await Future.wait([
      Future.delayed(const Duration(seconds: 5)),
      authRepository.isLoggedIn(),
    ]);
    isLoggedIn = result[1];
    _pageStack = [AppPage.home];
    notifyListeners();
  }

  List<AppPage> _pageStack = [AppPage.splash];

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  AppPage get currentConfiguration => _pageStack.last;

  bool isLoggedIn = false;
  int currentBottomNavigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    final productProvider = context.read<ProductProvider>();
    final cartProvider = context.read<CartProvider>();

    return Scaffold(
      body: Navigator(
        key: navigatorKey,
        pages: _pageStack.map((page) {
          switch (page) {
            case AppPage.home:
              currentBottomNavigationIndex = 0;
              Future.microtask(() async {
                productProvider.getNewProductsHome();
                productProvider.getBestSellerProductsHome();
              });
              return MaterialPage(
                key: ValueKey(AppPage.home),
                child: HomeScreen(onTapped: _handleTapped),
              );
            case AppPage.splash:
              return MaterialPage(
                key: ValueKey(AppPage.splash),
                child: SplashScreen(),
              );
            case AppPage.addroom:
              currentBottomNavigationIndex = 1;
              return MaterialPage(
                key: ValueKey(AppPage.addroom),
                child: AddRoomScreen(onTapped: _handleTapped),
              );
            case AppPage.chat:
              currentBottomNavigationIndex = 1;
              return MaterialPage(
                key: ValueKey(AppPage.chat),
                child: ChatScreen(onTapped: _handleTapped),
              );
            case AppPage.shop:
              currentBottomNavigationIndex = 2;
              return MaterialPage(
                key: ValueKey(AppPage.shop),
                child: ShopScreen(onTapped: _handleTapped),
              );
            case AppPage.cart:
              currentBottomNavigationIndex = 3;
              Future.microtask(() async {
                cartProvider.getCarts();
              });
              return MaterialPage(
                key: ValueKey(AppPage.cart),
                child: CartScreen(onTapped: _handleTapped),
              );
            case AppPage.profile:
              currentBottomNavigationIndex = 4;
              return MaterialPage(
                key: ValueKey(AppPage.profile),
                child: ProfilScreen(onTapped: _handleTapped),
              );
            case AppPage.login:
              currentBottomNavigationIndex = 4;
              return MaterialPage(
                key: ValueKey(AppPage.login),
                child: LoginScreen(onTapped: _handleTapped),
              );
            case AppPage.register:
              currentBottomNavigationIndex = 4;
              return MaterialPage(
                key: ValueKey(AppPage.register),
                child: RegisterScreen(onTapped: _handleTapped),
              );
            case AppPage.detailProduct:
              return MaterialPage(
                key: ValueKey(AppPage.detailProduct),
                child: DetailProduct(onTapped: _handleTapped),
              );
            case AppPage.riwayat:
              final historyTransactionProvider =
                  context.read<HistoryTransactionProvider>();

              Future.microtask(() async {
                historyTransactionProvider.getTransactions();
              });
              return MaterialPage(
                key: ValueKey(AppPage.riwayat),
                child: RiwayatScreen(onTapped: _handleTapped),
              );
            case AppPage.registerkonsul:
              currentBottomNavigationIndex = 4;
              return MaterialPage(
                key: ValueKey(AppPage.registerkonsul),
                child: RegisterKonsulScreen(onTapped: _handleTapped),
              );
            case AppPage.registeraddress:
              currentBottomNavigationIndex = 4;
              return MaterialPage(
                key: ValueKey(AppPage.registeraddress),
                child: RegisterAddress(onTapped: _handleTapped),
              );
            case AppPage.checkout:
              currentBottomNavigationIndex = 3;
              return MaterialPage(
                key: ValueKey(AppPage.checkout),
                child: Checkout(onTapped: _handleTapped),
              );
            case AppPage.setting:
              currentBottomNavigationIndex = 4;
              return MaterialPage(
                key: ValueKey(AppPage.setting),
                child: SettingScreen(onTapped: _handleTapped),
              );
          }
        }).toList(),
        onPopPage: (route, result) {
          final didPop = route.didPop(result);

          if (!didPop) {
            return false;
          }

          _pageStack.removeLast();
          currentBottomNavigationIndex = 0;

          // handleCurrentBottomNavigationIndexFromPage(_pageStack.last);

          notifyListeners();

          return true;
        },
      ),
      bottomNavigationBar: bottomNavPages.contains(_pageStack.last)
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 0,
              currentIndex: currentBottomNavigationIndex,
              backgroundColor: Colors.green,
              selectedItemColor: Color(0xFF198754),
              unselectedItemColor: Colors.white,
              onTap: (index) {
                if (index == 0) {
                  _handleTapped(AppPage.home);
                } else if (index == 1) {
                  _handleTapped(AppPage.addroom);
                } else if (index == 2) {
                  _handleTapped(AppPage.shop);
                } else if (index == 3) {
                  _handleTapped(AppPage.cart);
                } else if (index == 4) {
                  _handleTapped(AppPage.setting);
                }
                notifyListeners();
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_bubble_rounded), label: ""),
                BottomNavigationBarItem(
                    icon: Icon(Icons.store_rounded), label: ""),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_rounded), label: ""),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
              ],
            )
          : null,
    );
  }

  void _handleTapped(AppPage page) async {
    // handleCurrentBottomNavigationIndexFromPage(page);

    isLoggedIn = await authRepository.isLoggedIn();
    if (authRequiredPages.contains(page) && !isLoggedIn) {
      // Jika mengunjungi halaman yang perlu login dan belum login
      _pageStack.removeWhere((page) => !authPages.contains(page));
      _pageStack.add(_handleDuplicatePage(AppPage.login));
    } else if (authPages.contains(page) && isLoggedIn) {
      // Jika mengunjungi halaman untuk login atau register dan sudah login
      _pageStack.removeWhere((page) => authPages.contains(page));
      _pageStack.add(_handleDuplicatePage(AppPage.home));
    } else {
      if (page == AppPage.addroom &&
          !(await authRepository.isConsultationDataComplete())) {
        _pageStack.add(_handleDuplicatePage(AppPage.registerkonsul));
      } else if (page == AppPage.checkout &&
          !(await authRepository.isChekoutDataComplete())) {
        _pageStack.add(_handleDuplicatePage(AppPage.registeraddress));
      } else {
        _pageStack.add(_handleDuplicatePage(page));
      }
    }

    if (_pageStack.last != AppPage.checkout)
      _pageStack.removeWhere((page) => page == AppPage.checkout);

    notifyListeners();
  }

  AppPage _handleDuplicatePage(AppPage page) {
    if (!_pageStack.contains(page)) {
      return page;
    } else {
      _pageStack.remove(page);
      return page;
    }
  }

  void handleCurrentBottomNavigationIndexFromPage(AppPage page) {
    if (page == AppPage.home) {
      currentBottomNavigationIndex = 0;
      // } else if (page == AppPage.shop) {
      //   currentBottomNavigationIndex = 1;
    } else if (page == AppPage.profile ||
        page == AppPage.login ||
        page == AppPage.register) {
      currentBottomNavigationIndex = 4;
    }
  }

  @override
  Future<void> setNewRoutePath(configuration) async {
    if (_pageStack.isEmpty || _pageStack.last != configuration) {
      _pageStack.add(configuration);
    }
  }
}
