import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:calcio/controllers/calculator_controller.dart';
import 'package:calcio/widgets/calc_button.dart';
import 'package:calcio/theme/app_theme.dart';

class CalculatorView extends GetView<CalculatorController> {
  const CalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isDark = theme.brightness == Brightness.dark;

    // Extracted colors
    final txtHigh = colorScheme.onSurface;
    final primary = colorScheme.primary;
    final operatorBg = isDark ? AppTheme.operatorColor : AppTheme.lightSurfaceHigh;
    final keypadSurface = isDark ? AppTheme.darkSurface : AppTheme.lightSurface;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calcio'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Display Area
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Obx(
                        () => Text(
                          controller.expression.value,
                          style: theme.textTheme.headlineSmall,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => Text(
                        controller.result.value,
                        style: theme.textTheme.displayLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Keypad Area Base Surface
            Expanded(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                  color: keypadSurface,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                child: Column(
                  children: [
                    // Memory & Advanced Functions row
                    // Memory & Advanced Functions row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left side DEG/RAD indicator
                        Obx(() => Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  controller.isRad.value ? 'RAD' : 'DEG',
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    color: primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  width: 4,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: primary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            )),
                        // Right side Memory
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: ['MC', 'MR', 'M-', 'M+'].map((e) {
                              return GestureDetector(
                                onTap: () => controller.onButtonPressed(e),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 26.0),
                                  child: Text(
                                    e,
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      color: txtHigh.withValues(alpha: 0.8),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Main Grid
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: _buildMainColumn(operatorBg, txtHigh),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 1,
                            child: _buildRightColumn(
                              operatorBg,
                              txtHigh,
                              primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainColumn(Color btnBg, Color txtHigh) {
    return Column(
      children: [
        Expanded(child: _buildRow(['sin', 'cos', 'tan'], btnBg, txtHigh)),
        const SizedBox(height: 12),
        Expanded(child: _buildRow(['log', 'ln', '√'], btnBg, txtHigh)),
        const SizedBox(height: 12),
        Expanded(child: _buildRow(['7', '8', '9'], btnBg, txtHigh)),
        const SizedBox(height: 12),
        Expanded(child: _buildRow(['4', '5', '6'], btnBg, txtHigh)),
        const SizedBox(height: 12),
        Expanded(child: _buildRow(['1', '2', '3'], btnBg, txtHigh)),
        const SizedBox(height: 12),
        Expanded(child: _buildRow(['DEL', '0', '.'], btnBg, txtHigh)),
      ],
    );
  }

  Widget _buildRightColumn(
    Color btnBg,
    Color txtHigh,
    Color primary,
  ) {
    return Column(
      children: [
        Expanded(
          child: CalcButton(
            text: 'AC',
            backgroundColor: btnBg,
            textColor: txtHigh,
            onTap: () => controller.onButtonPressed('AC'),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: CalcButton(
            text: '÷',
            backgroundColor: btnBg,
            textColor: primary,
            onTap: () => controller.onButtonPressed('÷'),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: CalcButton(
            text: '×',
            backgroundColor: btnBg,
            textColor: primary,
            onTap: () => controller.onButtonPressed('×'),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: CalcButton(
            text: '−',
            backgroundColor: btnBg,
            textColor: primary,
            onTap: () => controller.onButtonPressed('−'),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: CalcButton(
            text: '+',
            backgroundColor: btnBg,
            textColor: primary,
            onTap: () => controller.onButtonPressed('+'),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          flex: 1,
          child: CalcButton(
            text: '=',
            isPrimary: true,
            backgroundColor: primary,
            textColor: const Color(0xFF00363D),
            onTap: () => controller.onButtonPressed('='),
            subText: null,
          ),
        ),
      ],
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

  // History modal removed
}
