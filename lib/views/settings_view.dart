import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:calcio/controllers/calculator_controller.dart';
import 'package:calcio/theme/app_theme.dart';

class SettingsView extends GetView<CalculatorController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader(context, 'Appearance'),
          Card(
            elevation: 0,
            color: AppTheme.darkSurface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Icon(
                isDark ? Icons.dark_mode : Icons.light_mode,
                color: theme.colorScheme.primary,
              ),
              title: const Text('Dark Mode'),
              subtitle: const Text('Toggle application theme'),
              trailing: Switch(
                value: isDark,
                onChanged: (value) => controller.toggleTheme(),
                activeThumbColor: theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader(context, 'Data'),
          Card(
            elevation: 0,
            color: AppTheme.darkSurface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.delete_sweep,
                color: Colors.redAccent,
              ),
              title: const Text('Clear History'),
              subtitle: const Text('Remove all stored calculation history'),
              onTap: () {
                Get.defaultDialog(
                  title: 'Clear History',
                  middleText: 'Are you sure you want to clear all history?',
                  textConfirm: 'Clear',
                  textCancel: 'Cancel',
                  confirmTextColor: Colors.white,
                  buttonColor: Colors.redAccent,
                  onConfirm: () {
                    controller.clearHistory();
                    Get.back(); // close dialog
                    Get.snackbar(
                      'Success',
                      'History cleared successfully.',
                      snackPosition: SnackPosition.BOTTOM,
                      margin: const EdgeInsets.all(16),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader(context, 'About'),
          Card(
            elevation: 0,
            color: AppTheme.darkSurface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: const ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Calcio Version'),
              subtitle: Text('1.0.0'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
