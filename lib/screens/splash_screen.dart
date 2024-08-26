import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    init(GoRouter.of(context));
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', height: 150),
          ],
        ),
      ),
    );
  }

  Future<void> init(GoRouter router) async {
    //do some long running task
    Future.delayed(
        const Duration(seconds: 5), () => router.pushReplacement('/'));
  }
}
