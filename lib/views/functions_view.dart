import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:calcio/controllers/calculator_controller.dart';
import 'package:calcio/theme/app_theme.dart';

class FunctionsView extends GetView<CalculatorController> {
  const FunctionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final txtHigh = colorScheme.onSurface;
    final isDark = theme.brightness == Brightness.dark;
    final operatorBg = isDark ? AppTheme.operatorColor : AppTheme.lightSurfaceHigh;
    final keypadSurface = isDark ? AppTheme.darkSurface : AppTheme.lightSurface;
    final primary = colorScheme.primary;
    final bg = isDark ? AppTheme.darkBackground : AppTheme.lightBackground;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // === Premium Header ===
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top bar
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
                    const SizedBox(height: 28),
                    // Title
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Functions\n',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 34,
                              fontWeight: FontWeight.w700,
                              color: txtHigh,
                              height: 1.2,
                            ),
                          ),
                          TextSpan(
                            text: 'Library',
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
                    Text(
                      'Tap any function to add it to your expression.',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: txtHigh.withValues(alpha: 0.45),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // === Sections ===
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Trigonometry
                  _buildSectionContainer(
                    keypadSurface,
                    isDark,
                    Column(
                      children: [
                        _buildSectionHeader(
                          Icons.change_history_rounded,
                          'Trigonometry',
                          primary,
                          txtHigh,
                        ),
                        GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 2.2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            _buildGridButton('sin', 'SINE', operatorBg, txtHigh, primary, isDark),
                            _buildGridButton('cos', 'COSINE', operatorBg, txtHigh, primary, isDark),
                            _buildGridButton('tan', 'TANGENT', operatorBg, txtHigh, primary, isDark),
                            _buildGridButton('csc', 'COSEC', operatorBg, txtHigh, primary, isDark),
                            _buildGridButton('sin⁻¹', 'ARCSIN', operatorBg, txtHigh, primary, isDark),
                            _buildGridButton('cos⁻¹', 'ARCCOS', operatorBg, txtHigh, primary, isDark),
                            _buildGridButton('tan⁻¹', 'ARCTAN', operatorBg, txtHigh, primary, isDark),
                            _buildGridButton('hyp', 'HYPER', operatorBg, txtHigh, primary, isDark),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Calculus
                  _buildSectionContainer(
                    keypadSurface,
                    isDark,
                    Column(
                      children: [
                        _buildSectionHeader(
                          Icons.functions_rounded,
                          'Calculus',
                          primary,
                          txtHigh,
                        ),
                        _buildListButton('∫', 'Integral', 'DEFINITE / INDEFINITE', operatorBg, txtHigh, primary, '∫', isDark),
                        _buildListButton('d/dx', 'Derivative', 'N-TH ORDER', operatorBg, txtHigh, primary, 'd/dx', isDark),
                        _buildListButton('lim', 'Limit', 'ASYMPTOTIC', operatorBg, txtHigh, primary, 'lim', isDark),
                      ],
                    ),
                  ),

                  // Variables
                  _buildSectionContainer(
                    keypadSurface,
                    isDark,
                    Column(
                      children: [
                        _buildSectionHeader(
                          Icons.data_object_rounded,
                          'Variables',
                          primary,
                          txtHigh,
                        ),
                        GridView.count(
                          crossAxisCount: 3,
                          childAspectRatio: 1.2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            _buildGridButton('x', '', operatorBg, txtHigh, primary, isDark, isItalic: true),
                            _buildGridButton('y', '', operatorBg, txtHigh, primary, isDark, isItalic: true),
                            _buildGridButton('z', '', operatorBg, txtHigh, primary, isDark, isItalic: true),
                            _buildGridButton('a', '', operatorBg, txtHigh, primary, isDark, isItalic: true),
                            _buildGridButton('b', '', operatorBg, txtHigh, primary, isDark, isItalic: true),
                            _buildGridButton('c', '', operatorBg, txtHigh, primary, isDark, isItalic: true),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: operatorBg,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                                side: BorderSide(
                                  color: isDark
                                      ? Colors.white.withValues(alpha: 0.06)
                                      : Colors.black.withValues(alpha: 0.06),
                                  width: 0.5,
                                ),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.edit_outlined,
                                  size: 16,
                                  color: txtHigh.withValues(alpha: 0.5),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Manage Custom Variables',
                                  style: GoogleFonts.inter(
                                    color: txtHigh.withValues(alpha: 0.6),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Universal Constants
                  _buildSectionContainer(
                    keypadSurface,
                    isDark,
                    Column(
                      children: [
                        _buildSectionHeader(
                          Icons.all_inclusive_rounded,
                          'Universal Constants',
                          primary,
                          txtHigh,
                        ),
                        _buildConstantButton('π', 'Pi', '3.14159265...', operatorBg, txtHigh, primary, 'π', isDark),
                        _buildConstantButton('e', "Euler's Number", '2.71828182...', operatorBg, txtHigh, primary, 'e', isDark),
                        _buildConstantButton('φ', 'Golden Ratio', '1.61803398...', operatorBg, txtHigh, primary, 'φ', isDark),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    IconData icon,
    String title,
    Color primary,
    Color txtHigh,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: primary, size: 18),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: txtHigh,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionContainer(Color bg, bool isDark, Widget child) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.black.withValues(alpha: 0.05),
          width: 0.5,
        ),
      ),
      child: child,
    );
  }

  Widget _buildGridButton(
    String text,
    String subText,
    Color bg,
    Color txtHigh,
    Color primary,
    bool isDark, {
    bool isItalic = false,
  }) {
    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          controller.onButtonPressed(text);
        },
        borderRadius: BorderRadius.circular(16),
        splashColor: primary.withValues(alpha: 0.1),
        highlightColor: primary.withValues(alpha: 0.05),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.04)
                  : Colors.black.withValues(alpha: 0.04),
              width: 0.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: GoogleFonts.inter(
                  fontSize: isItalic ? 24 : 18,
                  fontWeight: FontWeight.w600,
                  fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
                  color: isItalic ? primary : txtHigh,
                ),
              ),
              if (subText.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  subText,
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: txtHigh.withValues(alpha: 0.35),
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListButton(
    String symbol,
    String title,
    String subtitle,
    Color bg,
    Color txtHigh,
    Color primary,
    String command,
    bool isDark,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            controller.onButtonPressed(command);
          },
          borderRadius: BorderRadius.circular(16),
          splashColor: primary.withValues(alpha: 0.1),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.04)
                    : Colors.black.withValues(alpha: 0.04),
                width: 0.5,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    symbol,
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: primary,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: txtHigh,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        subtitle,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: txtHigh.withValues(alpha: 0.35),
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: txtHigh.withValues(alpha: 0.2),
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConstantButton(
    String symbol,
    String title,
    String value,
    Color bg,
    Color txtHigh,
    Color primary,
    String command,
    bool isDark,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            controller.onButtonPressed(command);
          },
          borderRadius: BorderRadius.circular(16),
          splashColor: primary.withValues(alpha: 0.1),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.04)
                    : Colors.black.withValues(alpha: 0.04),
                width: 0.5,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        primary.withValues(alpha: 0.15),
                        primary.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: primary.withValues(alpha: 0.15),
                      width: 0.5,
                    ),
                  ),
                  child: Text(
                    symbol,
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: primary,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: txtHigh,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        value,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: primary.withValues(alpha: 0.7),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.info_outline_rounded,
                    size: 16,
                    color: primary.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
