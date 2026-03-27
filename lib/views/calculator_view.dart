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

    // Extracted colors
    final bg = colorScheme.surface;
    final txtHigh = colorScheme.onSurface;
    final primary = colorScheme.primary;
    final operatorBg = AppTheme.operatorColor;

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
                  color: AppTheme.darkSurface,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                child: Column(
                  children: [
                    // Memory & Advanced Functions row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ['MC', 'MR', 'M-', 'M+', 'DEL', 'AC'].map((e) {
                        return GestureDetector(
                          onTap: () => controller.onButtonPressed(e),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: e == 'AC' || e == 'DEL'
                                  ? Colors.redAccent.withValues(alpha: 0.1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              e,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: e == 'AC' || e == 'DEL'
                                    ? Colors.redAccent
                                    : primary,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),

                    // Main Grid
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: _buildMainColumn(bg, txtHigh),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 1,
                            child: _buildRightColumn(
                              operatorBg,
                              txtHigh,
                              primary,
                              bg,
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

  Widget _buildMainColumn(Color bg, Color txtHigh) {
    return Column(
      children: [
        Expanded(child: _buildRow(['sin', 'cos', 'tan'], bg, txtHigh)),
        const SizedBox(height: 12),
        Expanded(child: _buildRow(['ln', 'log', '√'], bg, txtHigh)),
        const SizedBox(height: 12),
        Expanded(child: _buildRow(['7', '8', '9'], bg, txtHigh)),
        const SizedBox(height: 12),
        Expanded(child: _buildRow(['4', '5', '6'], bg, txtHigh)),
        const SizedBox(height: 12),
        Expanded(child: _buildRow(['1', '2', '3'], bg, txtHigh)),
        const SizedBox(height: 12),
        Expanded(child: _buildRow(['%', '0', '.'], bg, txtHigh)),
      ],
    );
  }

  Widget _buildRightColumn(
    Color operatorBg,
    Color txtHigh,
    Color primary,
    Color bg,
  ) {
    return Column(
      children: [
        Expanded(
          child: CalcButton(
            text: 'x²',
            backgroundColor: bg,
            textColor: txtHigh,
            onTap: () => controller.onButtonPressed('x²'),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: CalcButton(
            text: '÷',
            backgroundColor: operatorBg,
            textColor: txtHigh,
            onTap: () => controller.onButtonPressed('÷'),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: CalcButton(
            text: '×',
            backgroundColor: operatorBg,
            textColor: txtHigh,
            onTap: () => controller.onButtonPressed('×'),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: CalcButton(
            text: '−',
            backgroundColor: operatorBg,
            textColor: txtHigh,
            onTap: () => controller.onButtonPressed('−'),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: CalcButton(
            text: '+',
            backgroundColor: operatorBg,
            textColor: txtHigh,
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
