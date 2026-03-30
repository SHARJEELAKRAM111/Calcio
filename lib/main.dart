import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:calcio/theme/app_theme.dart';
import 'package:calcio/views/splash_view.dart';
import 'package:calcio/services/storage_service.dart';
import 'package:calcio/controllers/calculator_controller.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Immersive status bar for splash
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  final prefs = await SharedPreferences.getInstance();
  Get.put(StorageService(prefs));
  Get.put(CalculatorController());

  // Remove native splash — our animated splash takes over
  FlutterNativeSplash.remove();

  runApp(const CalcioApp());
}

class CalcioApp extends StatelessWidget {
  const CalcioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = Get.find<StorageService>();
    return GetMaterialApp(
      title: 'Calcio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getLightTheme(const Color(0xFF00E5FF)),
      darkTheme: AppTheme.getDarkTheme(const Color(0xFF00E5FF)),
      themeMode: storage.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const SplashView(),
    );
  }
}
