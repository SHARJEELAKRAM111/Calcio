import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:calcio/controllers/main_controller.dart';
import 'package:calcio/views/calculator_view.dart';
import 'package:calcio/views/functions_view.dart';
import 'package:calcio/views/history_view.dart';
import 'package:calcio/views/settings_view.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());

    final List<Widget> pages = [
      const CalculatorView(),
      const FunctionsView(),
      const HistoryView(),
      const SettingsView(),
    ];

    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.currentIndex.value,
            children: pages,
          )),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: controller.changePage,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.calculate_outlined),
              selectedIcon: Icon(Icons.calculate),
              label: 'Calculator',
            ),
            NavigationDestination(
              icon: Icon(Icons.functions_outlined),
              selectedIcon: Icon(Icons.functions),
              label: 'Functions',
            ),
            NavigationDestination(
              icon: Icon(Icons.history_outlined),
              selectedIcon: Icon(Icons.history),
              label: 'History',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
