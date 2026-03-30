import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:calcio/controllers/calculator_controller.dart';
import 'package:calcio/controllers/main_controller.dart';
import 'package:calcio/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryView extends GetView<CalculatorController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final primary = colorScheme.primary;
    final txtHigh = colorScheme.onSurface;
    final bg = isDark ? AppTheme.darkBackground : AppTheme.lightBackground;
    final cardBg = isDark ? AppTheme.darkSurface : AppTheme.lightSurface;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === Header ===
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      // Delete button
                      Obx(() {
                        if (controller.history.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return GestureDetector(
                          onTap: () => _showClearDialog(context, isDark, primary),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF4444).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFFF4444).withValues(alpha: 0.15),
                                width: 0.5,
                              ),
                            ),
                            child: Icon(
                              Icons.delete_sweep_rounded,
                              color: const Color(0xFFFF6B6B),
                              size: 20,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 28),
                  // Title
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Calculation\n',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                            color: txtHigh,
                            height: 1.2,
                          ),
                        ),
                        TextSpan(
                          text: 'History',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                            color: primary,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(() => Text(
                        '${controller.history.length} calculations',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: txtHigh.withValues(alpha: 0.4),
                        ),
                      )),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // === History List ===
            Expanded(
              child: Obx(() {
                if (controller.history.isEmpty) {
                  return _buildEmptyState(txtHigh, primary, isDark);
                }

                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  itemCount: controller.history.length,
                  itemBuilder: (context, index) {
                    final entry = controller.history[index];
                    final parts = entry.split(' = ');
                    final expression = parts.isNotEmpty ? parts[0] : '';
                    final result = parts.length > 1 ? parts[1] : '';

                    return TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: Duration(milliseconds: 300 + (index * 50).clamp(0, 300)),
                      curve: Curves.easeOutCubic,
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 20 * (1 - value)),
                            child: child,
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Material(
                          color: cardBg,
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              controller.expression.value = expression;
                              controller.result.value = result;
                              Get.find<MainController>().changePage(0);
                            },
                            borderRadius: BorderRadius.circular(20),
                            splashColor: primary.withValues(alpha: 0.08),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isDark
                                      ? Colors.white.withValues(alpha: 0.05)
                                      : Colors.black.withValues(alpha: 0.05),
                                  width: 0.5,
                                ),
                              ),
                              child: Row(
                                children: [
                                  // Index badge
                                  Container(
                                    width: 36,
                                    height: 36,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: primary.withValues(alpha: 0.08),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      '${index + 1}',
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: primary.withValues(alpha: 0.6),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  // Content
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          expression,
                                          style: GoogleFonts.spaceGrotesk(
                                            fontSize: 14,
                                            color: txtHigh.withValues(alpha: 0.5),
                                            fontWeight: FontWeight.w400,
                                          ),
                                          textAlign: TextAlign.right,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          '= $result',
                                          style: GoogleFonts.spaceGrotesk(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700,
                                            color: primary,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 14,
                                    color: txtHigh.withValues(alpha: 0.15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(Color txtHigh, Color primary, bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated empty icon
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: primary.withValues(alpha: 0.06),
              shape: BoxShape.circle,
              border: Border.all(
                color: primary.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Icon(
              Icons.history_rounded,
              size: 44,
              color: primary.withValues(alpha: 0.3),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No calculations yet',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: txtHigh.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your calculation history will appear here.',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: txtHigh.withValues(alpha: 0.3),
            ),
          ),
          const SizedBox(height: 32),
          GestureDetector(
            onTap: () => Get.find<MainController>().changePage(0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: primary.withValues(alpha: 0.2),
                  width: 0.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.calculate_rounded, size: 18, color: primary),
                  const SizedBox(width: 8),
                  Text(
                    'Start Calculating',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearDialog(BuildContext context, bool isDark, Color primary) {
    final txtHigh = isDark ? Colors.white : const Color(0xFF131313);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1C1B1B) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          border: Border(
            top: BorderSide(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.08),
              width: 0.5,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: txtHigh.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFFF4444).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete_sweep_rounded,
                color: Color(0xFFFF6B6B),
                size: 32,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Clear All History?',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: txtHigh,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This will permanently delete all your calculation history.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: txtHigh.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.06)
                            : Colors.black.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: txtHigh.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.clearHistory();
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF4444),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          'Clear All',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
