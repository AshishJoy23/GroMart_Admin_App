import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gromart_admin_app/view/config/config.dart';
import 'package:gromart_admin_app/view/screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      title: 'GroMart Admin',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: const SplashScreen(),
      getPages: [
        GetPage(name: '/home', page: () => HomeScreen()),
      ],
    );
  }
}
