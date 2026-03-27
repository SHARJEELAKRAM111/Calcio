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
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: storage.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const MainView(),
    );
  }
}
