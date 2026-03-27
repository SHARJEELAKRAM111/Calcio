import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:calcio/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:calcio/theme/app_theme.dart';

class CalculatorController extends GetxController {
  var expression = ''.obs;
  var result = '0'.obs;
  var isRad = true.obs;
  var history = <String>[].obs;
  var memory = 0.0.obs;

  // Settings State
  var precision = 12.obs;
  var significantFigures = true.obs;
  var accentColor = 'Cyan'.obs;

  final StorageService _storage = Get.find<StorageService>();

  var isDarkMode = false.obs; // Added

  void resetPreferences() {
    precision.value = 12;
    significantFigures.value = true;
    accentColor.value = 'Cyan';
    isRad.value = true;
  }

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = _storage.isDarkMode;
    history.assignAll(_storage.getHistory());
    
    // Defer the theme application so GetMaterialApp is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _applyTheme();
    });
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
    _applyTheme();
  }

  void _applyTheme() {
    ThemeData newTheme = isDarkMode.value 
        ? AppTheme.getDarkTheme(getPrimaryColor()) 
        : AppTheme.getLightTheme(getPrimaryColor());
    Get.changeTheme(newTheme);
  }

  void onButtonPressed(String text) {
    if (result.value == 'Error') result.value = '0';
    if (result.value == '0' && text != '.' && text != 'AC' && text != '=') {
      // Starting condition
    }

    switch (text) {
      case 'AC':
        expression.value = '';
        result.value = '0';
        break;
      case 'DEL':
        if (expression.value.isNotEmpty) {
          expression.value = expression.value.substring(
            0,
            expression.value.length - 1,
          );
        }
        calculateResult(real: false);
        break;
      case '=':
        calculateResult(real: true);
        expression.value = result.value;
        break;
      case 'DEG':
      case 'RAD':
        isRad.value = !isRad.value;
        break;
      case 'M+':
        memory.value += double.tryParse(result.value) ?? 0.0;
        break;
      case 'M-':
        memory.value -= double.tryParse(result.value) ?? 0.0;
        break;
      case 'MR':
        expression.value += memory.value.toString();
        break;
      case 'MC':
        memory.value = 0.0;
        break;
      case 'sin':
      case 'cos':
      case 'tan':
      case 'log':
      case 'ln':
      case '√':
        expression.value += '$text(';
        break;
      case 'x²':
        expression.value += '^2';
        calculateResult(real: false);
        break;
      case 'xʸ':
        expression.value += '^';
        break;
      case '!':
        expression.value += '!';
        calculateResult(real: false);
        break;
      case 'π':
        expression.value += 'pi';
        calculateResult(real: false);
        break;
      case 'e':
        expression.value += 'e';
        calculateResult(real: false);
        break;
      default:
        expression.value += text;
        calculateResult(real: false);
    }
  }

  void calculateResult({bool real = false}) {
    if (expression.value.isEmpty) {
      if (real) result.value = '0';
      return;
    }

    try {
      String expStr = expression.value;
      expStr = expStr.replaceAll('√', 'sqrt');
      expStr = expStr.replaceAll('π', 'pi');
      expStr = expStr.replaceAll('×', '*');
      expStr = expStr.replaceAll('÷', '/');
      expStr = expStr.replaceAll('−', '-');
      expStr = expStr.replaceAll(
        '!',
        '!',
      ); // handled natively by parser usually

      // We will parse standard functions
      if (!isRad.value) {
        // Advanced parsing for Degrees vs Radians is complex, keeping simple for this iteration
      }

      GrammarParser p = GrammarParser();
      Expression exp = p.parse(expStr);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      String resStr = eval.toString();
      if (resStr.endsWith('.0')) {
        resStr = resStr.substring(0, resStr.length - 2);
      }

      result.value = resStr;

      if (real && expression.value.isNotEmpty) {
        history.insert(0, '${expression.value} = $resStr');
        if (history.length > 30) history.removeLast();
        _storage.saveHistory(history.toList());
      }
    } catch (e) {
      if (real) result.value = 'Error';
    }
  }

  void clearHistory() {
    history.clear();
    _storage.saveHistory([]);
  }
}
