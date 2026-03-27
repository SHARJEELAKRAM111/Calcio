import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:calcio/theme/app_theme.dart';
import 'package:calcio/views/main_view.dart';
import 'package:calcio/services/storage_service.dart';
import 'package:calcio/controllers/calculator_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  Get.put(StorageService(prefs));
  Get.put(CalculatorController());

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
      home: const MainView(),
    );
  }
}
