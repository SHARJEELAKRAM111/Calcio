import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:calcio/controllers/calculator_controller.dart';
import 'package:calcio/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsView extends GetView<CalculatorController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = controller.isDarkMode.value;
      final primary = controller.getPrimaryColor();
      final bg = isDark ? AppTheme.darkBackground : AppTheme.lightBackground;
      final cardBg = isDark ? AppTheme.darkSurface : AppTheme.lightSurface;
      final textGrey = isDark
          ? const Color(0xFFB6B4B7)
          : const Color(0xFF555555);
      final textMain = isDark ? Colors.white : const Color(0xFF131313);

      return Scaffold(
        backgroundColor: bg,
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // === Header ===
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      const SizedBox(height: 28),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'App\n',
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 34,
                                fontWeight: FontWeight.w700,
                                color: textMain,
                                height: 1.2,
                              ),
                            ),
                            TextSpan(
                              text: 'Settings',
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
                        'Configure your precision instrument.',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: textGrey.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // === Content ===
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // CALCULATION SECTION
                    _buildSectionHeader(
                      Icons.grid_view_rounded,
                      'CALCULATION',
                      primary,
                      textGrey,
                    ),
                    const SizedBox(height: 12),
                    _buildCard(
                      cardBg,
                      isDark,
                      Column(
                        children: [
                          _buildSliderRow(primary, textGrey, textMain, isDark),
                          _buildDivider(isDark),
                          _buildToggleRow(primary, textGrey, textMain, isDark),
                          _buildDivider(isDark),
                          _buildSwitchRow(
                            'Significant Figures',
                            'Limit output to significant digits',
                            primary,
                            textGrey,
                            textMain,
                            isDark,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // VISUALS SECTION
                    _buildSectionHeader(
                      Icons.palette_outlined,
                      'VISUALS',
                      primary,
                      textGrey,
                    ),
                    const SizedBox(height: 12),
                    _buildCard(
                      cardBg,
                      isDark,
                      Column(
                        children: [
                          _buildThemeRow(textGrey, textMain, isDark, primary),
                          _buildDivider(isDark),
                          _buildAccentColorRow(primary, textGrey, textMain, isDark),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ABOUT SECTION
                    _buildSectionHeader(
                      Icons.info_outline_rounded,
                      'ABOUT',
                      primary,
                      textGrey,
                    ),
                    const SizedBox(height: 12),
                    _buildCard(
                      cardBg,
                      isDark,
                      Column(
                        children: [
                          _buildAboutRow(
                            Icons.code_rounded,
                            'Version',
                            'v2.4.0-obsidian',
                            textMain,
                            textGrey,
                            primary,
                            isDark,
                          ),
                          _buildDivider(isDark),
                          _buildAboutRow(
                            Icons.shield_outlined,
                            'Privacy Policy',
                            'Data usage and security',
                            textMain,
                            textGrey,
                            primary,
                            isDark,
                            trailing: Icon(
                              Icons.open_in_new_rounded,
                              color: textMain.withValues(alpha: 0.3),
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // RESET BUTTON
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        controller.resetPreferences();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFFFF4444).withValues(alpha: 0.25),
                            width: 1,
                          ),
                          color: const Color(0xFFFF4444).withValues(alpha: 0.05),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.restart_alt_rounded,
                                size: 18,
                                color: isDark
                                    ? const Color(0xFFFF8A80)
                                    : const Color(0xFFD32F2F),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Reset All Preferences',
                                style: GoogleFonts.inter(
                                  color: isDark
                                      ? const Color(0xFFFF8A80)
                                      : const Color(0xFFD32F2F),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ]),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildCard(Color cardBg, bool isDark, Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.black.withValues(alpha: 0.05),
          width: 0.5,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: child,
    );
  }

  Widget _buildDivider(bool isDark) {
    return Divider(
      height: 1,
      thickness: 0.5,
      color: isDark
          ? Colors.white.withValues(alpha: 0.06)
          : Colors.black.withValues(alpha: 0.06),
    );
  }

  Widget _buildSectionHeader(
    IconData icon,
    String title,
    Color primary,
    Color textGrey,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: primary, size: 14),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: GoogleFonts.inter(
              color: textGrey.withValues(alpha: 0.7),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderRow(
      Color primary, Color textGrey, Color textMain, bool isDark) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Precision',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: textMain,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${controller.precision.value}',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      color: primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Decimal places for results',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: textGrey.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SliderTheme(
              data: SliderThemeData(
                trackHeight: 3,
                activeTrackColor: primary,
                inactiveTrackColor: textMain.withValues(alpha: 0.1),
                thumbColor: primary,
                overlayColor: primary.withValues(alpha: 0.15),
                thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 7),
              ),
              child: Slider(
                value: controller.precision.value.toDouble(),
                min: 0,
                max: 15,
                divisions: 15,
                onChanged: (val) {
                  HapticFeedback.selectionClick();
                  controller.precision.value = val.toInt();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleRow(
    Color primary,
    Color textGrey,
    Color textMain,
    bool isDark,
  ) {
    return Obx(() {
      bool isDeg = !controller.isRad.value;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Default Units',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: textMain,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Angle measurement mode',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: textGrey.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : Colors.black.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(3),
              child: Row(
                children: [
                  _buildToggleChip('DEG', isDeg, primary, isDark, () {
                    HapticFeedback.selectionClick();
                    controller.isRad.value = false;
                  }),
                  const SizedBox(width: 2),
                  _buildToggleChip('RAD', !isDeg, primary, isDark, () {
                    HapticFeedback.selectionClick();
                    controller.isRad.value = true;
                  }),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildToggleChip(
    String label,
    bool isActive,
    Color primary,
    bool isDark,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
            color: isActive
                ? (isDark ? const Color(0xFF131313) : Colors.white)
                : (isDark
                    ? Colors.white.withValues(alpha: 0.4)
                    : Colors.black.withValues(alpha: 0.4)),
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchRow(
    String title,
    String subtitle,
    Color primary,
    Color textGrey,
    Color textMain,
    bool isDark,
  ) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: textMain,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: textGrey.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Switch(
              value: controller.significantFigures.value,
              onChanged: (val) {
                HapticFeedback.selectionClick();
                controller.significantFigures.value = val;
              },
              activeThumbColor: isDark ? const Color(0xFF131313) : Colors.white,
              activeTrackColor: primary,
              inactiveTrackColor: isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.08),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeRow(
    Color textGrey,
    Color textMain,
    bool isDark,
    Color primary,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Theme',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: textMain,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'App color mode',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: textGrey.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.06)
                  : Colors.black.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(3),
            child: Row(
              children: [
                _buildThemeOption(
                  Icons.wb_sunny_rounded,
                  !isDark,
                  primary,
                  isDark,
                  () {
                    HapticFeedback.selectionClick();
                    if (isDark) controller.toggleTheme();
                  },
                ),
                const SizedBox(width: 2),
                _buildThemeOption(
                  Icons.nightlight_round,
                  isDark,
                  primary,
                  isDark,
                  () {
                    HapticFeedback.selectionClick();
                    if (!isDark) controller.toggleTheme();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(
    IconData icon,
    bool isActive,
    Color primary,
    bool isDark,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Icon(
          icon,
          size: 18,
          color: isActive
              ? (isDark ? const Color(0xFF131313) : Colors.white)
              : (isDark
                  ? Colors.white.withValues(alpha: 0.4)
                  : Colors.black.withValues(alpha: 0.4)),
        ),
      ),
    );
  }

  Widget _buildAccentColorRow(
    Color primary,
    Color textGrey,
    Color textMain,
    bool isDark,
  ) {
    final colors = [
      {'name': 'Cyan', 'color': const Color(0xFF00E5FF)},
      {'name': 'Pink', 'color': const Color(0xFFFF2A85)},
      {'name': 'Yellow', 'color': const Color(0xFFFFD500)},
    ];

    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Color Accent',
              style: GoogleFonts.inter(
                fontSize: 15,
                color: textMain,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Primary UI highlight',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: textGrey.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: colors.map((c) {
                bool isSelected = controller.accentColor.value == c['name'];
                final accentColor = c['color'] as Color;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      controller.accentColor.value = c['name'] as String;
                      controller.updateAccentColor();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: isSelected ? 0.08 : 0.04)
                            : Colors.black.withValues(alpha: isSelected ? 0.06 : 0.03),
                        border: Border.all(
                          color: isSelected
                              ? accentColor.withValues(alpha: 0.6)
                              : Colors.transparent,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: accentColor,
                              shape: BoxShape.circle,
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: accentColor.withValues(alpha: 0.4),
                                        blurRadius: 12,
                                        spreadRadius: 2,
                                      ),
                                    ]
                                  : null,
                            ),
                            child: isSelected
                                ? Icon(
                                    Icons.check_rounded,
                                    size: 16,
                                    color: isDark
                                        ? const Color(0xFF131313)
                                        : Colors.white,
                                  )
                                : null,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            c['name'] as String,
                            style: GoogleFonts.inter(
                              color: isSelected
                                  ? accentColor
                                  : textMain.withValues(alpha: 0.6),
                              fontSize: 12,
                              fontWeight:
                                  isSelected ? FontWeight.w600 : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutRow(
    IconData icon,
    String title,
    String subtitle,
    Color textMain,
    Color textGrey,
    Color primary,
    bool isDark, {
    Widget? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: primary, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: textMain,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: textGrey.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          trailing ??
              Icon(
                Icons.chevron_right_rounded,
                color: textMain.withValues(alpha: 0.2),
                size: 22,
              ),
        ],
      ),
    );
  }
}
