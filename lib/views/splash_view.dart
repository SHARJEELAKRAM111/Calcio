import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:calcio/views/main_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  // Master orchestrator
  late AnimationController _masterController;

  // Icon animations
  late Animation<double> _iconScale;
  late Animation<double> _iconOpacity;
  late Animation<double> _glowIntensity;
  late Animation<double> _glowPulse;

  // Ring animations
  late AnimationController _ringController;
  late Animation<double> _ringRotation;
  late Animation<double> _ringOpacity;

  // Text animations
  late Animation<double> _titleOpacity;
  late Animation<double> _titleSlide;
  late Animation<double> _subtitleOpacity;
  late Animation<double> _letterSpacing;

  // Particles
  late AnimationController _particleController;

  // Exit animation
  late Animation<double> _exitScale;
  late Animation<double> _exitOpacity;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startSequence();
  }

  void _setupAnimations() {
    // Master controller — runs the full splash sequence
    _masterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    );

    // === Phase 1: Icon entrance (0% → 30%) ===
    _iconOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.0, 0.20, curve: Curves.easeOut),
      ),
    );

    _iconScale = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.0, 0.30, curve: Curves.elasticOut),
      ),
    );

    // === Phase 2: Glow blossoms (15% → 50%) ===
    _glowIntensity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.15, 0.50, curve: Curves.easeInOut),
      ),
    );

    // === Phase 3: Title reveal (35% → 60%) ===
    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.35, 0.55, curve: Curves.easeOut),
      ),
    );

    _titleSlide = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.35, 0.60, curve: Curves.easeOutCubic),
      ),
    );

    _letterSpacing = Tween<double>(begin: 12.0, end: 6.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.35, 0.65, curve: Curves.easeOut),
      ),
    );

    // === Phase 4: Subtitle (50% → 70%) ===
    _subtitleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.50, 0.70, curve: Curves.easeOut),
      ),
    );

    // === Phase 5: Exit (85% → 100%) ===
    _exitScale = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.85, 1.0, curve: Curves.easeInCubic),
      ),
    );

    _exitOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.88, 1.0, curve: Curves.easeIn),
      ),
    );

    // Glow pulse — continuous subtle pulsing
    _glowPulse = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.30, 0.85, curve: Curves.easeInOut),
      ),
    );

    // === Rotating ring ===
    _ringController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 6000),
    );

    _ringRotation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _ringController, curve: Curves.linear),
    );

    _ringOpacity = Tween<double>(begin: 0.0, end: 0.4).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.20, 0.45, curve: Curves.easeOut),
      ),
    );

    // === Floating particles ===
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );
  }

  void _startSequence() async {
    // Start ring rotation & particles
    _ringController.repeat();
    _particleController.repeat();

    // Start master sequence
    await _masterController.forward();

    // Navigate to main app
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MainView(),
          transitionDuration: const Duration(milliseconds: 600),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _masterController.dispose();
    _ringController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131313),
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _masterController,
          _ringController,
          _particleController,
        ]),
        builder: (context, _) {
          return Opacity(
            opacity: _exitOpacity.value,
            child: Transform.scale(
              scale: _exitScale.value,
              child: Stack(
                children: [
                  // Subtle background gradient
                  _buildBackground(),

                  // Floating particles
                  _buildParticles(),

                  // Center content
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Rotating ring + Icon
                        _buildIconComposition(),

                        const SizedBox(height: 48),

                        // Title — CALCIO
                        _buildTitle(),

                        const SizedBox(height: 12),

                        // Subtitle
                        _buildSubtitle(),
                      ],
                    ),
                  ),

                  // Bottom version text
                  _buildVersionLabel(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBackground() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.8,
            colors: [
              const Color(0xFF00E5FF).withValues(
                alpha: 0.03 * _glowIntensity.value,
              ),
              const Color(0xFF131313),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParticles() {
    return Positioned.fill(
      child: CustomPaint(
        painter: _ParticlePainter(
          progress: _particleController.value,
          opacity: _glowIntensity.value * 0.5,
        ),
      ),
    );
  }

  Widget _buildIconComposition() {
    const double iconSize = 120;

    return SizedBox(
      width: iconSize * 2,
      height: iconSize * 2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer glow
          Opacity(
            opacity: _glowIntensity.value * _glowPulse.value * 0.6,
            child: Container(
              width: iconSize * 1.8,
              height: iconSize * 1.8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00E5FF).withValues(alpha: 0.15),
                    blurRadius: 80,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),

          // Rotating dashed ring
          Transform.rotate(
            angle: _ringRotation.value,
            child: Opacity(
              opacity: _ringOpacity.value,
              child: CustomPaint(
                size: Size(iconSize * 1.6, iconSize * 1.6),
                painter: _DashedRingPainter(
                  color: const Color(0xFF00E5FF),
                  strokeWidth: 1.5,
                ),
              ),
            ),
          ),

          // Counter-rotating inner ring
          Transform.rotate(
            angle: -_ringRotation.value * 0.7,
            child: Opacity(
              opacity: _ringOpacity.value * 0.5,
              child: CustomPaint(
                size: Size(iconSize * 1.35, iconSize * 1.35),
                painter: _DashedRingPainter(
                  color: const Color(0xFF00E5FF),
                  strokeWidth: 0.8,
                  dashCount: 24,
                ),
              ),
            ),
          ),

          // The app icon
          Opacity(
            opacity: _iconOpacity.value,
            child: Transform.scale(
              scale: _iconScale.value,
              child: Container(
                width: iconSize,
                height: iconSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00E5FF).withValues(
                        alpha: 0.3 * _glowIntensity.value,
                      ),
                      blurRadius: 40 * _glowIntensity.value,
                      spreadRadius: 5 * _glowIntensity.value,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Image.asset(
                    'assets/icons/app_icon.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Opacity(
      opacity: _titleOpacity.value,
      child: Transform.translate(
        offset: Offset(0, _titleSlide.value),
        child: Text(
          'CALCIO',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 38,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: _letterSpacing.value,
          ),
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return Opacity(
      opacity: _subtitleOpacity.value,
      child: Text(
        'PRECISION  ENGINEERING',
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF00E5FF).withValues(alpha: 0.7),
          letterSpacing: 4.0,
        ),
      ),
    );
  }

  Widget _buildVersionLabel() {
    return Positioned(
      bottom: 48,
      left: 0,
      right: 0,
      child: Opacity(
        opacity: _subtitleOpacity.value * 0.5,
        child: Text(
          'v2.4.0',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: Colors.white.withValues(alpha: 0.3),
            letterSpacing: 2.0,
          ),
        ),
      ),
    );
  }
}

// === Custom Painters ===

class _DashedRingPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final int dashCount;

  _DashedRingPainter({
    required this.color,
    this.strokeWidth = 1.5,
    this.dashCount = 36,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final dashAngle = (2 * math.pi) / dashCount;
    final gapRatio = 0.4;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = i * dashAngle;
      final sweepAngle = dashAngle * (1 - gapRatio);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ParticlePainter extends CustomPainter {
  final double progress;
  final double opacity;

  _ParticlePainter({required this.progress, required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    if (opacity < 0.01) return;

    final paint = Paint()..style = PaintingStyle.fill;
    final rng = math.Random(42); // Fixed seed for consistent particles

    for (int i = 0; i < 20; i++) {
      final baseX = rng.nextDouble() * size.width;
      final baseY = rng.nextDouble() * size.height;
      final speed = 0.3 + rng.nextDouble() * 0.7;
      final particleSize = 1.0 + rng.nextDouble() * 2.0;

      // Floating upward motion
      final yOffset = (progress * speed * 200) % size.height;
      final x = baseX + math.sin(progress * 2 * math.pi + i) * 15;
      final y = (baseY - yOffset) % size.height;

      // Pulsing alpha
      final pulseAlpha = (math.sin(progress * 2 * math.pi + i * 0.5) + 1) / 2;

      paint.color = const Color(
        0xFF00E5FF,
      ).withValues(alpha: opacity * pulseAlpha * 0.6);

      canvas.drawCircle(Offset(x, y), particleSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}
