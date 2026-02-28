import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// ===========================================
/// Service Data Model
/// ===========================================
class Service {
  final IconData icon;
  final String title;
  final String description;
  final List<String> features;
  final List<Color> gradientColors;

  Service({
    required this.icon,
    required this.title,
    required this.description,
    required this.features,
    required this.gradientColors,
  });
}

/// ===========================================
/// List of Services
/// ===========================================
final List<Service> services = [
  Service(
    icon: Icons.monitor,
    title: "Web App Development",
    description:
        "Modern, responsive web applications built with React, TypeScript, and Vite.",
    features: [
      "Component-driven UI",
      "State management",
      "API integration",
      "Performance optimization",
    ],
    gradientColors: [Colors.blue, Colors.cyan],
  ),
  Service(
    icon: Icons.smartphone,
    title: "Mobile App Development",
    description:
        "Cross-platform mobile apps using Flutter and Dart, designed for speed and usability.",
    features: [
      "Flutter & Dart",
      "Responsive layouts",
      "API integration",
      "Smooth performance",
    ],
    gradientColors: [Colors.cyan, Colors.teal],
  ),
  Service(
    icon: Icons.shopping_cart,
    title: "E‑commerce & SaaS",
    description:
        "Feature-rich platforms with payments, subscriptions, and analytics.",
    features: [
      "Checkout flows",
      "Subscription logic",
      "Analytics dashboards",
      "Third-party integrations",
    ],
    gradientColors: [Colors.purple, Colors.pink],
  ),
];

/// ===========================================
/// Services Section Widget
/// ===========================================
class ServicesSection extends StatefulWidget {
  const ServicesSection({super.key});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
  final Set<int> _hoveredIndices = {};

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    // Responsive grid size - smaller on small screens, larger on big screens
    final gridSize = screenWidth < 600
        ? 25.0
        : screenWidth < 900
        ? 30.0
        : screenWidth < 1200
        ? 35.0
        : 40.0;

    final cardWidth = isMobile
        ? screenWidth -
              48.0 // Full width minus padding on mobile
        : (screenWidth < 1200
              ? (screenWidth - 72) /
                    2 // 2 columns on tablet
              : (screenWidth - 96) / 3); // 3 columns on desktop

    return Container(
      color: AppColors.navy,
      width: double.infinity,
      child: Stack(
        children: [
          // ===========================================
          // Grid Background - Full Width and Height
          // ===========================================
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: CustomPaint(
                painter: _GridPainter(
                  gridColor: AppColors.cyberBlue,
                  gridSize: gridSize,
                ),
                isComplex: true,
                willChange: false,
              ),
            ),
          ),

          // ===========================================
          // Content with Padding
          // ===========================================
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 96, horizontal: 24),
            child: Column(
              children: [
                // ===========================================
                // Section Header
                // ===========================================
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 18,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.charcoal,
                        border: Border.all(
                          color: AppColors.cyberBlue.withValues(alpha: 0.3),
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        "MY SERVICES",
                        style: TextStyle(
                          color: AppColors.cyberBlue,
                          letterSpacing: 2,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "How I can be helpful",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 700),
                      child: const Text(
                        "End-to-end design and development services to bring your ideas to life",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFCBD5E1),
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 64),

                // ===========================================
                // Services Grid
                // ===========================================
                if (isMobile)
                  // Mobile: Vertical stack
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(services.length, (index) {
                      final service = services[index];
                      final isHovered = _hoveredIndices.contains(index);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: _buildServiceCard(
                          service,
                          index,
                          isHovered,
                          cardWidth,
                          isMobile,
                        ),
                      );
                    }),
                  )
                else
                  // Desktop/Tablet: Grid
                  Wrap(
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    spacing: 24,
                    runSpacing: 24,
                    children: List.generate(services.length, (index) {
                      final service = services[index];
                      final isHovered = _hoveredIndices.contains(index);

                      return _buildServiceCard(
                        service,
                        index,
                        isHovered,
                        cardWidth,
                        isMobile,
                      );
                    }),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
    Service service,
    int index,
    bool isHovered,
    double cardWidth,
    bool isMobile,
  ) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _hoveredIndices.add(index);
        });
      },
      onExit: (_) {
        setState(() {
          _hoveredIndices.remove(index);
        });
      },
      cursor: SystemMouseCursors.click,
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            if (isHovered)
              BoxShadow(
                color: AppColors.cyberBlue.withValues(alpha: 0.2),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.charcoal,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isHovered
                  ? AppColors.cyberBlue.withValues(alpha: 0.6)
                  : AppColors.cyberBlue.withValues(alpha: 0.25),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: isMobile
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              // ===========================================
              // Icon with Gradient
              // ===========================================
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: service.gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: service.gradientColors[0].withValues(alpha: 0.3),
                      blurRadius: 12,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Icon(service.icon, color: Colors.white, size: 32),
              ),
              const SizedBox(height: 20),

              // ===========================================
              // Title & Description
              // ===========================================
              Text(
                service.title,
                textAlign: isMobile ? TextAlign.center : TextAlign.left,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  height: 1.3,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                service.description,
                textAlign: isMobile ? TextAlign.center : TextAlign.left,
                style: const TextStyle(
                  color: Color(0xFFCBD5E1),
                  fontSize: 14,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),

              // ===========================================
              // Features
              // ===========================================
              Column(
                crossAxisAlignment: isMobile
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: service.features
                    .map(
                      (feature) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: isMobile
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              margin: const EdgeInsets.only(top: 6, right: 10),
                              decoration: const BoxDecoration(
                                color: AppColors.cyberBlue,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                feature,
                                textAlign: isMobile
                                    ? TextAlign.center
                                    : TextAlign.left,
                                style: const TextStyle(
                                  color: Color(0xFFCBD5E1),
                                  fontSize: 14,
                                  height: 1.4,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ===========================================
/// Grid Painter (L-shaped pattern)
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
