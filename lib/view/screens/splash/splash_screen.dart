import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gromart_admin_app/view/screens/screens.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const GetStartedPage(),
      //   ),
      // );
      Get.offAll(() => const GetStartedPage());
    });
    return Scaffold(
      backgroundColor: const Color(0xff4CAF50),
      body: Center(
        child: Image.asset(
          'assets/images/gromart_splash.png',
        ),
      ),
    );
  }
}
