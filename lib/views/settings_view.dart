import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:calcio/controllers/calculator_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsView extends GetView<CalculatorController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = controller.isDarkMode.value;
      final primary = controller.getPrimaryColor();
      final bg = isDark ? const Color(0xFF131313) : const Color(0xFFF0F0F0);
      final cardBg = isDark ? const Color(0xFF1C1B1B) : Colors.white;
      final textGrey = isDark
          ? const Color(0xFFB6B4B7)
          : const Color(0xFF555555);
      final textMain = isDark ? Colors.white : const Color(0xFF131313);

      return Scaffold(
        backgroundColor: bg,
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
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            // Header
            Text(
              'Settings',
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: textMain,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Configure your precision instrument.',
              style: GoogleFonts.inter(fontSize: 14, color: textGrey),
            ),
            const SizedBox(height: 32),

            // CALCULATION SECTION
            _buildSectionHeader(
              Icons.grid_view_rounded,
              'CALCULATION',
              primary,
              textGrey,
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildSliderRow(primary, textGrey, textMain),
                  const SizedBox(height: 24),
                  _buildToggleRow(primary, textGrey, textMain, isDark),
                  const SizedBox(height: 24),
                  _buildSwitchRow(
                    'Significant Figures',
                    'Limit output to significant digits',
                    true,
                    primary,
                    textGrey,
                    textMain,
                    isDark,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // VISUALS SECTION
            _buildSectionHeader(Icons.palette, 'VISUALS', primary, textGrey),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildThemeRow(
                    'Theme',
                    'App color mode',
                    isDark,
                    primary,
                    textGrey,
                    textMain,
                  ),
                  const SizedBox(height: 24),
                  _buildAccentColorRow(primary, textGrey, textMain, isDark),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // ABOUT SECTION
            _buildSectionHeader(Icons.info, 'ABOUT', primary, textGrey),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    title: Text(
                      'Version',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: textMain,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      'v2.4.0-obsidian',
                      style: GoogleFonts.inter(fontSize: 13, color: textGrey),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: textMain.withValues(alpha: 0.54),
                    ),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    title: Text(
                      'Privacy Policy',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: textMain,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      'Data usage and security',
                      style: GoogleFonts.inter(fontSize: 13, color: textGrey),
                    ),
                    trailing: Icon(
                      Icons.open_in_new,
                      color: textMain.withValues(alpha: 0.54),
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 48),

            // RESET BUTTON
            OutlinedButton(
              onPressed: () => controller.resetPreferences(),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: isDark
                      ? const Color(0xFF3B494C)
                      : const Color(0xFFD0D0D0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Reset All Preferences',
                style: GoogleFonts.inter(
                  color: isDark
                      ? const Color(0xFFFFB4AB)
                      : const Color(0xFFD32F2F),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      );
    });
  }

  Widget _buildSectionHeader(
    IconData icon,
    String title,
    Color primary,
    Color textGrey,
  ) {
    return Row(
      children: [
        Icon(icon, color: primary, size: 16),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.inter(
            color: textGrey,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSliderRow(Color primary, Color textGrey, Color textMain) {
    return Obx(
      () => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Precision',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: textMain,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${controller.precision.value} Decimals',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 2,
              activeTrackColor: primary,
              inactiveTrackColor: textMain.withValues(alpha: 0.24),
              thumbColor: primary,
              overlayColor: primary.withValues(alpha: 0.2),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
            ),
            child: Slider(
              value: controller.precision.value.toDouble(),
              min: 0,
              max: 15,
              divisions: 15,
              onChanged: (val) => controller.precision.value = val.toInt(),
            ),
          ),
        ],
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
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Default Units',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: textMain,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Angle measurement mode',
                  style: GoogleFonts.inter(fontSize: 13, color: textGrey),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => controller.isRad.value = false, // Set to DEG
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isDeg ? primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'DEG',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isDeg
                            ? (isDark ? Colors.black : Colors.white)
                            : textGrey,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.isRad.value = true, // Set to RAD
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: !isDeg ? primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'RAD',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: !isDeg
                            ? (isDark ? Colors.black : Colors.white)
                            : textGrey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildSwitchRow(
    String title,
    String subtitle,
    bool isSettingsSwitch,
    Color primary,
    Color textGrey,
    Color textMain,
    bool isDark,
  ) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: textMain,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(fontSize: 13, color: textGrey),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Switch(
            value: controller.significantFigures.value,
            onChanged: (val) => controller.significantFigures.value = val,
            activeThumbColor: isDark ? Colors.black : Colors.white,
            activeTrackColor: primary,
            inactiveTrackColor: isDark
                ? const Color(0xFF353534)
                : const Color(0xFFD0D0D0),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeRow(
    String title,
    String subtitle,
    bool isDark,
    Color primary,
    Color textGrey,
    Color textMain,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: textMain,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.inter(fontSize: 13, color: textGrey),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Row(
          children: [
            Icon(Icons.wb_sunny_outlined, color: textMain, size: 20),
            const SizedBox(width: 8),
            Switch(
              value: isDark,
              onChanged: (val) => controller.toggleTheme(),
              activeThumbColor: isDark ? Colors.black : Colors.white,
              activeTrackColor: primary,
              inactiveThumbColor: isDark ? Colors.white : Colors.black,
              inactiveTrackColor: isDark
                  ? const Color(0xFF353534)
                  : const Color(0xFFD0D0D0),
            ),
            const SizedBox(width: 8),
            Icon(Icons.nightlight_round, color: primary, size: 20),
          ],
        ),
      ],
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
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Color Accent',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: textMain,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Primary UI highlight',
            style: GoogleFonts.inter(fontSize: 13, color: textGrey),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: colors.map((c) {
              bool isSelected = controller.accentColor.value == c['name'];
              return GestureDetector(
                onTap: () {
                  controller.accentColor.value = c['name'] as String;
                  controller.updateAccentColor();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF2A2A2A)
                        : const Color(0xFFE0E0E0),
                    border: Border.all(
                      color: isSelected
                          ? (c['color'] as Color)
                          : Colors.transparent,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: c['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        c['name'] as String,
                        style: GoogleFonts.inter(
                          color: textMain,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
