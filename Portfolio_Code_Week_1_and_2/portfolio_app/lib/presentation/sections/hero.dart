import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// ===========================================
/// Hero Section Widget
/// Converted from React → Flutter
/// ===========================================
class HeroSection extends StatefulWidget {
  final VoidCallback onViewProjects;
  final VoidCallback onContact;

  const HeroSection({
    super.key,
    required this.onViewProjects,
    required this.onContact,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _scanController;

  @override
  void initState() {
    super.initState();
    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _scanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;
    final gridSize = size.width < 600
        ? 25.0
        : size.width < 900
        ? 30.0
        : size.width < 1200
        ? 35.0
        : 40.0;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          // ===========================================
          // BACKGROUND IMAGE
          // ===========================================
          Positioned.fill(
            child: Image.asset(
              'assets/img/background_pic.png',
              fit: BoxFit.cover,
            ),
          ),

          // ===========================================
          // OVERLAY GRADIENT
          // ===========================================
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF0A0F1C),
                    const Color(0xFF0A0F1C).withValues(alpha: 0.9),
                    const Color(0xFF0A0F1C),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // ===========================================
          // GRID PATTERN EFFECT
          // ===========================================
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: CustomPaint(
                painter: _GridPainter(
                  gridColor: const Color(0xFF00d4ff),
                  gridSize: gridSize,
                ),
              ),
            ),
          ),

          // ===========================================
          // SCANNING LINE EFFECT (Repeating Animation)
          // ===========================================
          AnimatedBuilder(
            animation: _scanController,
            builder: (context, child) {
              // Map 0-1 animation to -100% to 200% position
              final position =
                  -size.height + (_scanController.value * size.height * 3);
              return Positioned(
                top: position,
                left: 0,
                right: 0,
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        const Color(0xFF00d4ff).withValues(alpha: 0.5),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // ===========================================
          // HERO CONTENT
          // ===========================================
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ===========================================
                  // MAIN HEADLINE
                  // ===========================================
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: isMobile ? 520 : 900),
                    child: Column(
                      children: [
                        const Text(
                          "Hi, I’m Muhammad Khurram",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [Colors.white, AppColors.cyberBlue],
                          ).createShader(bounds),
                          child: const Text(
                            "I develop modern web and mobile experiences - fast, secure, and designed to last.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -1,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ===========================================
                  // SUBHEADLINE / SKILLS
                  // ===========================================
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      _skillItem(Icons.monitor, "Web Development"),
                      //  _dividerDot(),
                      _skillItem(Icons.smartphone, "Mobile App Development"),
                      //_dividerDot(),
                      _skillItem(Icons.memory, "Aspiring AI Engineer"),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // ===========================================
                  // CTA BUTTONS
                  // ===========================================
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    runSpacing: 12,
                    children: [
                      _ctaButton(
                        "View Projects",
                        widget.onViewProjects,
                        primary: true,
                      ),
                      _ctaButton("Contact Me", widget.onContact),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================
  // SINGLE SKILL ITEM
  // ===========================================
  Widget _skillItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: Color(0xFF00d4ff)),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }

  // ===========================================
  // DOT DIVIDER BETWEEN SKILLS
  // ===========================================
  // Widget _dividerDot() {
  //   return const Text(
  //     "•",
  //     style: TextStyle(color: Color(0xFF00d4ff), fontWeight: FontWeight.bold),
  //   );
  // }

  // ===========================================
  // CTA BUTTON
  // ===========================================
  Widget _ctaButton(
    String text,
    VoidCallback onPressed, {
    bool primary = false,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: primary ? Color(0xFF00d4ff) : Colors.transparent,
        side: primary ? null : BorderSide(color: Color(0xFF00d4ff)),
        foregroundColor: primary ? Colors.black : Color(0xFF00d4ff),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(text),
    );
  }
}

/// ===========================================
/// Grid Pattern Painter
/// ===========================================
class _GridPainter extends CustomPainter {
  final Color gridColor;
  final double gridSize;

  _GridPainter({required this.gridColor, required this.gridSize});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    // Draw L-shaped lines (top and left borders of each cell)
    for (double x = 0; x <= size.width; x += gridSize) {
      for (double y = 0; y <= size.height; y += gridSize) {
        // Draw top border
        canvas.drawLine(Offset(x, y), Offset(x + gridSize, y), paint);
        // Draw left border
        canvas.drawLine(Offset(x, y), Offset(x, y + gridSize), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.gridColor != gridColor ||
        oldDelegate.gridSize != gridSize;
  }
}
