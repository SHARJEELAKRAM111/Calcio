import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:calcio/services/storage_service.dart';
import 'package:calcio/theme/app_theme.dart';

class MainController extends GetxController {
  var currentIndex = 0.obs;
  var isDarkMode = false.obs;
  var accentColor = 'Cyan'.obs;

  final StorageService _storage = Get.find<StorageService>();

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = _storage.isDarkMode;
    accentColor.value = _storage.accentColor;
    
    // Defer the theme application so GetMaterialApp is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _applyTheme();
    });
  }

  void changePage(int index) {
    currentIndex.value = index;
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    _storage.saveThemeMode(isDarkMode.value);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    _applyTheme();
  }

  Color getPrimaryColor() {
    switch (accentColor.value) {
      case 'Pink': return const Color(0xFFFF2A85);
      case 'Yellow': return const Color(0xFFFFD500);
      default: return const Color(0xFF00E5FF); // Cyan
    }
  }

  void updateAccentColor() {
    _storage.saveAccentColor(accentColor.value);
    _applyTheme();
  }

  void _applyTheme() {
    ThemeData newTheme = isDarkMode.value 
        ? AppTheme.getDarkTheme(getPrimaryColor()) 
        : AppTheme.getLightTheme(getPrimaryColor());
    Get.changeTheme(newTheme);
  }
}
