import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:calcio/controllers/calculator_controller.dart';
import 'package:calcio/widgets/calc_button.dart';
import 'package:calcio/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final bg = isDark ? AppTheme.darkBackground : AppTheme.lightBackground;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            // === Top Bar ===
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // App logo/name
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: primary.withValues(alpha: 0.4),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'CALCIO',
                        style: GoogleFonts.spaceGrotesk(
                          color: primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          letterSpacing: 3,
                        ),
                      ),
                    ],
                  ),
                  // Mode indicator
                  Obx(
                    () => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: primary.withValues(alpha: 0.2),
                          width: 0.5,
                        ),
                      ),
                      child: Text(
                        controller.isRad.value ? 'RAD' : 'DEG',
                        style: GoogleFonts.spaceGrotesk(
                          color: primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // === Display Area ===
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 16,
                ),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Expression
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Obx(
                        () => AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                            color: txtHigh.withValues(alpha: 0.45),
                            letterSpacing: 1,
                          ),
                          child: Text(
                            controller.expression.value,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Result with glow effect
                    Obx(() {
                      final res = controller.result.value;
                      final isError = res == 'Error';
                      return ShaderMask(
                        shaderCallback: (bounds) {
                          if (isError) {
                            return const LinearGradient(
                              colors: [Color(0xFFFF4444), Color(0xFFFF6B6B)],
                            ).createShader(bounds);
                          }
                          return LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              txtHigh,
                              txtHigh.withValues(alpha: 0.85),
                            ],
                          ).createShader(bounds);
                        },
                        child: Text(
                          res,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: res.length > 12
                                ? 38
                                : res.length > 8
                                    ? 46
                                    : 56,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: -2,
                            height: 1.1,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

            // === Keypad Area ===
            Expanded(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                  color: keypadSurface,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(36),
                  ),
                  border: Border(
                    top: BorderSide(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.06)
                          : Colors.black.withValues(alpha: 0.06),
                      width: 0.5,
                    ),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                child: Column(
                  children: [
                    // Memory row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: ['MC', 'MR', 'M−', 'M+'].map((e) {
                          return GestureDetector(
                            onTap: () => controller.onButtonPressed(
                              e == 'M−' ? 'M-' : e,
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(left: 6),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.white.withValues(alpha: 0.04)
                                    : Colors.black.withValues(alpha: 0.03),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                e,
                                style: GoogleFonts.inter(
                                  color: txtHigh.withValues(alpha: 0.6),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Main Grid
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: _buildMainColumn(operatorBg, txtHigh, primary),
                          ),
                          const SizedBox(width: 10),
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

  Widget _buildMainColumn(Color btnBg, Color txtHigh, Color primary) {
    return Column(
      children: [
        Expanded(
          child: _buildRow(
            ['sin', 'cos', 'tan'],
            btnBg,
            primary.withValues(alpha: 0.9),
            isFn: true,
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: _buildRow(
            ['log', 'ln', '√'],
            btnBg,
            primary.withValues(alpha: 0.9),
            isFn: true,
          ),
        ),
        const SizedBox(height: 10),
        Expanded(child: _buildRow(['7', '8', '9'], btnBg, txtHigh)),
        const SizedBox(height: 10),
        Expanded(child: _buildRow(['4', '5', '6'], btnBg, txtHigh)),
        const SizedBox(height: 10),
        Expanded(child: _buildRow(['1', '2', '3'], btnBg, txtHigh)),
        const SizedBox(height: 10),
        Expanded(child: _buildRow(['DEL', '0', '.'], btnBg, txtHigh)),
      ],
    );
  }

  Widget _buildRightColumn(Color btnBg, Color txtHigh, Color primary) {
    return Column(
      children: [
        Expanded(
          child: CalcButton(
            text: 'AC',
            backgroundColor: btnBg,
            textColor: const Color(0xFFFF6B6B),
            onTap: () => controller.onButtonPressed('AC'),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: CalcButton(
            text: '÷',
            backgroundColor: btnBg,
            textColor: primary,
            onTap: () => controller.onButtonPressed('÷'),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: CalcButton(
            text: '×',
            backgroundColor: btnBg,
            textColor: primary,
            onTap: () => controller.onButtonPressed('×'),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: CalcButton(
            text: '−',
            backgroundColor: btnBg,
            textColor: primary,
            onTap: () => controller.onButtonPressed('−'),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: CalcButton(
            text: '+',
            backgroundColor: btnBg,
            textColor: primary,
            onTap: () => controller.onButtonPressed('+'),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          flex: 1,
          child: CalcButton(
            text: '=',
            isPrimary: true,
            backgroundColor: primary,
            textColor: const Color(0xFF00363D),
            onTap: () => controller.onButtonPressed('='),
          ),
        ),
      ],
    );
  }

  Widget _buildRow(
    List<String> items,
    Color bg,
    Color txtColor, {
    bool isFn = false,
  }) {
    return Row(
      children: items.map((item) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: CalcButton(
              text: item,
              backgroundColor: bg,
              textColor: txtColor,
              onTap: () => controller.onButtonPressed(item),
            ),
          ),
        );
      }).toList(),
    );
  }
}
