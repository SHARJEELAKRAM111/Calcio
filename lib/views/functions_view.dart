import 'package:flutter/material.dart';
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
    final operatorBg = isDark
        ? AppTheme.operatorColor
        : AppTheme.lightSurfaceHigh;
    final keypadSurface = isDark ? AppTheme.darkSurface : AppTheme.lightSurface;
    final primary = colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CALCIO',
          style: GoogleFonts.spaceGrotesk(
            color: primary,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header title
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Functions ',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: txtHigh,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: 'Library',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // // Search Field
              // TextField(
              //   decoration: InputDecoration(
              //     hintText: 'Search operations, constants, or variables...',
              //     hintStyle: GoogleFonts.inter(
              //       color: txtHigh.withValues(alpha: 0.5),
              //       fontSize: 14,
              //     ),
              //     prefixIcon: Icon(
              //       Icons.search,
              //       color: txtHigh.withValues(alpha: 0.5),
              //     ),
              //     filled: true,
              //     fillColor: keypadSurface,
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(12),
              //       borderSide: BorderSide.none,
              //     ),
              //     contentPadding: const EdgeInsets.symmetric(vertical: 0),
              //   ),
              // ),
              // const SizedBox(height: 32),

              // Trigonometry Section
              _buildSectionContainer(
                keypadSurface,
                Column(
                  children: [
                    _buildSectionHeader(
                      Icons.change_history,
                      'Trigonometry',
                      primary,
                      txtHigh,
                    ),
                    GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 2.2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildGridButton('sin', 'SINE', operatorBg, txtHigh),
                        _buildGridButton('cos', 'COSINE', operatorBg, txtHigh),
                        _buildGridButton('tan', 'TANGENT', operatorBg, txtHigh),
                        _buildGridButton('csc', 'COSEC', operatorBg, txtHigh),
                        _buildGridButton(
                          'sin⁻¹',
                          'ARCSIN',
                          operatorBg,
                          txtHigh,
                        ),
                        _buildGridButton(
                          'cos⁻¹',
                          'ARCCOS',
                          operatorBg,
                          txtHigh,
                        ),
                        _buildGridButton(
                          'tan⁻¹',
                          'ARCTAN',
                          operatorBg,
                          txtHigh,
                        ),
                        _buildGridButton('hyp', 'HYPER', operatorBg, txtHigh),
                      ],
                    ),
                  ],
                ),
              ),

              // Calculus Section
              _buildSectionContainer(
                keypadSurface,
                Column(
                  children: [
                    _buildSectionHeader(
                      Icons.functions,
                      'Calculus',
                      primary,
                      txtHigh,
                    ),
                    _buildListButton(
                      '∫',
                      'Integral',
                      'DEFINITE/INDEFINITE',
                      operatorBg,
                      txtHigh,
                      primary,
                      '∫',
                    ),
                    _buildListButton(
                      'd/dx',
                      'Derivative',
                      'N-TH ORDER',
                      operatorBg,
                      txtHigh,
                      primary,
                      'd/dx',
                    ),
                    _buildListButton(
                      'lim',
                      'Limit',
                      'ASYMPTOTIC',
                      operatorBg,
                      txtHigh,
                      primary,
                      'lim',
                    ),
                  ],
                ),
              ),

              // Variables Section
              _buildSectionContainer(
                keypadSurface,
                Column(
                  children: [
                    _buildSectionHeader(
                      Icons.remove,
                      'Variables',
                      primary,
                      txtHigh,
                    ),
                    GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: 1.2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildGridButton(
                          'x',
                          '',
                          operatorBg,
                          txtHigh,
                          isItalic: true,
                        ),
                        _buildGridButton(
                          'y',
                          '',
                          operatorBg,
                          txtHigh,
                          isItalic: true,
                        ),
                        _buildGridButton(
                          'z',
                          '',
                          operatorBg,
                          txtHigh,
                          isItalic: true,
                        ),
                        _buildGridButton(
                          'a',
                          '',
                          operatorBg,
                          txtHigh,
                          isItalic: true,
                        ),
                        _buildGridButton(
                          'b',
                          '',
                          operatorBg,
                          txtHigh,
                          isItalic: true,
                        ),
                        _buildGridButton(
                          'c',
                          '',
                          operatorBg,
                          txtHigh,
                          isItalic: true,
                        ),
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
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {},
                        child: Text(
                          'Manage Custom Variables',
                          style: GoogleFonts.inter(
                            color: txtHigh.withValues(alpha: 0.7),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Universal Constants Section
              _buildSectionContainer(
                keypadSurface,
                Column(
                  children: [
                    _buildSectionHeader(
                      Icons.ac_unit,
                      'Universal Constants',
                      primary,
                      txtHigh,
                    ),
                    _buildListButton(
                      'π',
                      'Pi',
                      '3.14159265...',
                      operatorBg,
                      txtHigh,
                      primary,
                      'π',
                      showInfo: true,
                    ),
                    _buildListButton(
                      'e',
                      'Euler\'s',
                      '2.71828182...',
                      operatorBg,
                      txtHigh,
                      primary,
                      'e',
                      showInfo: true,
                    ),
                    _buildListButton(
                      'φ',
                      'Golden Ratio',
                      '1.61803398...',
                      operatorBg,
                      txtHigh,
                      primary,
                      'φ',
                      showInfo: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
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
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Icon(icon, color: primary, size: 20),
          const SizedBox(width: 12),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: txtHigh,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionContainer(Color bg, Widget child) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(24),
      ),
      child: child,
    );
  }

  Widget _buildGridButton(
    String text,
    String subText,
    Color bg,
    Color txtHigh, {
    bool isItalic = false,
  }) {
    return GestureDetector(
      onTap: () {
        controller.onButtonPressed(text);
      },
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
                color: txtHigh,
              ),
            ),
            if (subText.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                subText,
                style: GoogleFonts.inter(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: txtHigh.withValues(alpha: 0.5),
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ],
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
    String command, {
    bool showInfo = false,
  }) {
    return GestureDetector(
      onTap: () {
        controller.onButtonPressed(command);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Text(
                    symbol,
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: primary,
                    ),
                  ),
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: txtHigh,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: txtHigh.withValues(alpha: 0.5),
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
                if (showInfo)
                  const SizedBox(width: 24), // Space matching info icon
              ],
            ),
            if (showInfo)
              Positioned(
                top: 0,
                right: 0,
                child: Icon(
                  Icons.info,
                  size: 14,
                  color: txtHigh.withValues(alpha: 0.5),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
