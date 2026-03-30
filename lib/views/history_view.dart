import 'package:calcio/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:calcio/controllers/calculator_controller.dart';
import 'package:calcio/controllers/main_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryView extends GetView<CalculatorController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final primary = colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
          style: GoogleFonts.spaceGrotesk(
            color: primary,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep, color: Colors.redAccent),
            onPressed: () {
              Get.defaultDialog(
                title: 'Clear History',
                middleText:
                    'Are you sure you want to clear all calculation history?',
                textConfirm: 'Clear',
                textCancel: 'Cancel',
                confirmTextColor: Colors.white,
                buttonColor: Colors.redAccent,
                onConfirm: () {
                  controller.clearHistory();
                  Get.back(); // close dialog
                },
              );
            },
          ),
        ],
        centerTitle: true,
      ),

      body: Obx(() {
        if (controller.history.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.history,
                  size: 64,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.2),
                ),
                const SizedBox(height: 16),
                Text(
                  'No history yet.',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.history.length,
          separatorBuilder: (context, index) =>
              const Divider(height: 1, thickness: 0.5),
          itemBuilder: (context, index) {
            final entry = controller.history[index];
            final parts = entry.split(' = ');
            final expression = parts.isNotEmpty ? parts[0] : '';
            final result = parts.length > 1 ? parts[1] : '';

            return InkWell(
              onTap: () {
                // Reuse expression and jump back to calculator
                controller.expression.value = expression;
                controller.result.value = result;
                Get.find<MainController>().changePage(
                  0,
                ); // Switch to calculator tab
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      expression,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '= $result',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
