import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:calcio/controllers/calculator_controller.dart';
import 'package:calcio/widgets/calc_button.dart';
import 'package:calcio/theme/app_theme.dart';

class FunctionsView extends GetView<CalculatorController> {
  const FunctionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bg = colorScheme.surface;
    final txtHigh = colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Functions'),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.darkSurface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(32),
            ),
          ),
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 24),
          child: Column(
            children: [
              // Expression Preview
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Obx(
                  () => Text(
                    controller.expression.value.isEmpty
                        ? '0'
                        : controller.expression.value,
                    style: theme.textTheme.headlineMedium,
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Functions Grid
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(child: _buildRow(['sin', 'cos', 'tan'], bg, txtHigh)),
                          const SizedBox(height: 12),
                          Expanded(child: _buildRow(['ln', 'log', '√'], bg, txtHigh)),
                          const SizedBox(height: 12),
                          Expanded(child: _buildRow(['π', 'e', '^'], bg, txtHigh)),
                          const SizedBox(height: 12),
                          Expanded(child: _buildRow(['!', '(', ')'], bg, txtHigh)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Bottom actions
              Row(
                children: [
                  Expanded(
                    child: CalcButton(
                      text: 'RAD / DEG',
                      backgroundColor: colorScheme.secondaryContainer,
                      textColor: colorScheme.onSecondaryContainer,
                      onTap: () => controller.onButtonPressed('RAD'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(List<String> items, Color bg, Color txtHigh) {
    return Row(
      children: items.map((item) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: CalcButton(
              text: item,
              backgroundColor: bg,
              textColor: txtHigh,
              onTap: () => controller.onButtonPressed(item),
            ),
          ),
        );
      }).toList(),
    );
  }
}
