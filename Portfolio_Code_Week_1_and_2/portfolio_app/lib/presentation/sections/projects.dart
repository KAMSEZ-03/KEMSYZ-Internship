import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_colors.dart';

/// ===========================================
/// Project Data Model
/// ===========================================
class Project {
  final IconData icon;
  final String title;
  final String description;
  final List<String> tech;
  final String liveUrl;
  final String repoUrl;
  final String status; // "Live", "Development", "Completed"
  // final int commits; // For stats display

  Project({
    required this.icon,
    required this.title,
    required this.description,
    required this.tech,
    required this.liveUrl,
    required this.repoUrl,
    this.status = "Completed",
    // this.commits = 0,
  });
}

/// ===========================================
/// List of Projects
/// ===========================================
final List<Project> projects = [
  Project(
    icon: Icons.code,
    title: "Portfolio Redesign",
    description:
        "A clean, responsive personal portfolio with modern UI, dark mode, and smooth interactions.",
    tech: ["React", "TypeScript", "Tailwind CSS"],
    liveUrl: "#",
    repoUrl: "#",
    status: "Completed",
    // commits: 142,
  ),
  Project(
    icon: Icons.smartphone,
    title: "Furnishia – E-commerce Mobile App",
    description:
        "A cross-platform e-commerce mobile app focused on smooth browsing, product discovery, and usability.",
    tech: ["Flutter", "Dart", "Firebase"],
    liveUrl: "#",
    repoUrl: "https://github.com/KAMSEZ-03/furniture_website",
    status: "Completed",
    // commits: 238,
  ),
  Project(
    icon: Icons.public,
    title: "Furnishia – E-commerce Website",
    description:
        "A modern e-commerce website with responsive design and a user-friendly shopping experience.",
    tech: [
      "HTML",
      "CSS",
      "JavaScript",
      "React",
      "Node.js",
      "Firebase",
      "TypeScript",
    ],
    liveUrl: "#",
    repoUrl: "#",
    status: "Completed",
    // commits: 312,
  ),
  Project(
    icon: Icons.smartphone,
    title: "Marks Tracking System",
    description:
        "A Flutter-based mobile application for managing and tracking academic marks. (Under Development)",
    tech: ["Flutter", "Dart", "SQLite"],
    liveUrl: "#",
    repoUrl: "#",
    status: "Development",
    // commits: 87,
  ),
  Project(
    icon: Icons.storage,
    title: "E-Nadra System",
    description:
        "A Java-based desktop system designed to manage citizen records with structured data handling.",
    tech: ["Java", "OOP", "Database Concepts"],
    liveUrl: "#",
    repoUrl: "#",
    status: "Completed",
    // commits: 156,
  ),
  Project(
    icon: Icons.storage,
    title: "University Maintenance System",
    description:
        "A Java-based system to manage and track university maintenance requests and operations.",
    tech: ["Java", "OOP", "Database Concepts", "Data Structures"],
    liveUrl: "#",
    repoUrl: "#",
    status: "Completed",
    // commits: 194,
  ),
];

/// ===========================================
/// Projects Section Widget
/// ===========================================
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  // Function to open external URLs
  bool _isValidUrl(String url) {
    if (url.trim().isEmpty || url == '#') return false;
    final uri = Uri.tryParse(url);
    return uri != null && (uri.hasScheme || url.startsWith('mailto:'));
  }

  Future<void> _launchUrl(String url) async {
    // Early return for invalid URLs
    if (url.trim().isEmpty || url == '#') return;

    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme) return;

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (e) {
      // Silently handle launch errors
      debugPrint('Failed to launch URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;
    final isTablet = screenWidth >= 800 && screenWidth < 1200;

    // Responsive grid size (like Hero section)
    final gridSize = screenWidth < 600
        ? 25.0
        : screenWidth < 900
        ? 30.0
        : screenWidth < 1200
        ? 35.0
        : 40.0;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.dark, AppColors.charcoal, AppColors.dark],
        ),
      ),
      child: Stack(
        children: [
          // Grid Background (matching Hero pattern)
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: CustomPaint(
                painter: _GridPainter(
                  gridColor: AppColors.cyberBlue,
                  gridSize: gridSize,
                ),
              ),
            ),
          ),

          // Gradient Overlays
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 300,
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.5,
                  colors: [
                    AppColors.cyberBlue.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            height: 300,
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.bottomRight,
                  radius: 1.2,
                  colors: [
                    AppColors.accentPurple.withValues(alpha: 0.06),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Main Content
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 48 : 80,
              horizontal: isMobile ? 20 : 40,
            ),
            child: Column(
              children: [
                // Section Header with Premium Badge
                _buildHeader(),
                SizedBox(height: isMobile ? 32 : 48),

                // Projects Grid
                _buildProjectsGrid(context, isMobile, isTablet),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Premium Badge
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.cyberBlue.withValues(alpha: 0.15),
                AppColors.neonBlue.withValues(alpha: 0.1),
              ],
            ),
            border: Border.all(
              color: AppColors.cyberBlue.withValues(alpha: 0.4),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: AppColors.cyberBlue.withValues(alpha: 0.2),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Container(
              //   width: 8,
              //   height: 8,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     color: AppColors.neonBlue,
              //     boxShadow: [
              //       BoxShadow(
              //         color: AppColors.neonBlue.withOpacity(0.6),
              //         blurRadius: 8,
              //         spreadRadius: 2,
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(width: 10),
              const Text(
                "FEATURED PROJECTS",
                style: TextStyle(
                  color: AppColors.neonBlue,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Main Title
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Colors.white, AppColors.cyberBlue],
          ).createShader(bounds),
          child: const Text(
            "Selected Work",
            style: TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
              height: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Subtitle
        Text(
          "Building exceptional digital experiences with cutting-edge technology",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 16,
            height: 1.6,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildProjectsGrid(
    BuildContext context,
    bool isMobile,
    bool isTablet,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = isMobile ? 1 : (isTablet ? 2 : 3);

        return Wrap(
          spacing: isMobile ? 16 : 24,
          runSpacing: isMobile ? 16 : 24,
          children: projects.asMap().entries.map((entry) {
            final index = entry.key;
            final project = entry.value;
            final cardWidth = isMobile
                ? constraints.maxWidth
                : (constraints.maxWidth - (columns - 1) * 24) / columns;

            return SizedBox(
              width: cardWidth,
              child: _ProjectCard(
                project: project,
                index: index,
                onLaunch: _launchUrl,
                isValidUrl: _isValidUrl,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

/// ===========================================
/// Grid Background Painter (L-shaped pattern like Hero)
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

/// ===========================================
/// Premium Project Card with Animations
/// ===========================================
class _ProjectCard extends StatefulWidget {
  final Project project;
  final int index;
  final Function(String) onLaunch;
  final bool Function(String) isValidUrl;

  const _ProjectCard({
    required this.project,
    required this.index,
    required this.onLaunch,
    required this.isValidUrl,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  Color _getStatusColor() {
    switch (widget.project.status) {
      case "Live":
        return const Color(0xFF00FF88);
      case "Development":
        return AppColors.accentPurple;
      default:
        return AppColors.cyberBlue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..translateByDouble(0.0, _isHovered ? -8.0 : 0.0, 0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.charcoal.withValues(alpha: 0.95),
                AppColors.dark.withValues(alpha: 0.9),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered
                  ? AppColors.cyberBlue.withValues(alpha: 0.5)
                  : AppColors.cyberBlue.withValues(alpha: 0.15),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? AppColors.cyberBlue.withValues(alpha: 0.25)
                    : Colors.black.withValues(alpha: 0.3),
                blurRadius: _isHovered ? 30 : 20,
                spreadRadius: _isHovered ? 2 : 0,
                offset: Offset(0, _isHovered ? 12 : 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                // Animated Corner Brackets (Inspired by UI sample)
                ..._buildCornerBrackets(),

                // Main Card Content
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header: Icon + Status
                      Row(
                        children: [
                          _buildIconBox(),
                          const Spacer(),
                          _buildStatusIndicator(),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Title
                      Text(
                        widget.project.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Description
                      Text(
                        widget.project.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.65),
                          fontSize: 14,
                          height: 1.6,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Divider with Gradient
                      Container(
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.cyberBlue.withValues(alpha: 0.4),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Tech Stack Badges
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.project.tech.map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.cyberBlue.withValues(alpha: 0.15),
                                  AppColors.cyberBlue.withValues(alpha: 0.05),
                                ],
                              ),
                              border: Border.all(
                                color: AppColors.cyberBlue.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              tech,
                              style: TextStyle(
                                color: AppColors.neonBlue,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),

                      // Stats Bar (Inspired by Infrastructure component)
                      // _buildStatsBar(),
                      // const SizedBox(height: 20),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: _buildActionButton(
                              label: "Live Demo",
                              icon: Icons.launch_rounded,
                              isPrimary: true,
                              isEnabled: widget.isValidUrl(
                                widget.project.liveUrl,
                              ),
                              onPressed: () =>
                                  widget.onLaunch(widget.project.liveUrl),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildActionButton(
                              label: "Source",
                              icon: Icons.code_rounded,
                              isPrimary: false,
                              isEnabled: widget.isValidUrl(
                                widget.project.repoUrl,
                              ),
                              onPressed: () =>
                                  widget.onLaunch(widget.project.repoUrl),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconBox() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.cyberBlue.withValues(alpha: 0.25),
            AppColors.neonBlue.withValues(alpha: 0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.cyberBlue.withValues(alpha: 0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.cyberBlue.withValues(alpha: 0.3),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Icon(widget.project.icon, color: AppColors.neonBlue, size: 28),
    );
  }

  Widget _buildStatusIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: _getStatusColor().withValues(alpha: 0.15),
        border: Border.all(color: _getStatusColor().withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getStatusColor(),
              boxShadow: [
                BoxShadow(
                  color: _getStatusColor().withValues(alpha: 0.6),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Text(
            widget.project.status,
            style: TextStyle(
              color: _getStatusColor(),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildStatsBar() {
  //   return Container(
  //     padding: const EdgeInsets.all(12),
  //     decoration: BoxDecoration(
  //       color: AppColors.dark.withOpacity(0.5),
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(color: AppColors.cyberBlue.withOpacity(0.15)),
  //     ),
  //     child: Row(
  //       children: [
  //         Icon(Icons.commit_rounded, color: AppColors.cyberBlue, size: 18),
  //         const SizedBox(width: 8),
  //         Text(
  //           "${widget.project.commits}",
  //           style: const TextStyle(
  //             color: Colors.white,
  //             fontSize: 16,
  //             fontWeight: FontWeight.w700,
  //           ),
  //         ),
  //         const SizedBox(width: 4),
  //         Text(
  //           "commits",
  //           style: TextStyle(
  //             color: Colors.white.withOpacity(0.5),
  //             fontSize: 12,
  //           ),
  //         ),
  //         const Spacer(),
  //         Container(
  //           padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
  //           decoration: BoxDecoration(
  //             gradient: LinearGradient(
  //               colors: [
  //                 AppColors.accentPurple.withOpacity(0.2),
  //                 AppColors.accentPurple.withOpacity(0.1),
  //               ],
  //             ),
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           child: Row(
  //             children: [
  //               Icon(
  //                 Icons.star_rounded,
  //                 color: AppColors.accentPurple,
  //                 size: 14,
  //               ),
  //               const SizedBox(width: 4),
  //               Text(
  //                 widget.project.tech.length.toString(),
  //                 style: TextStyle(
  //                   color: AppColors.accentPurple,
  //                   fontSize: 12,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required bool isPrimary,
    required bool isEnabled,
    required VoidCallback onPressed,
  }) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isEnabled ? 1.0 : 0.4,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              gradient: isPrimary
                  ? LinearGradient(
                      colors: [AppColors.cyberBlue, AppColors.neonBlue],
                    )
                  : null,
              color: isPrimary ? null : AppColors.dark.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isPrimary
                    ? AppColors.neonBlue.withValues(alpha: 0.5)
                    : AppColors.cyberBlue.withValues(alpha: 0.3),
                width: 1.5,
              ),
              boxShadow: isPrimary
                  ? [
                      BoxShadow(
                        color: AppColors.cyberBlue.withValues(alpha: 0.4),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isPrimary ? AppColors.dark : AppColors.cyberBlue,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: isPrimary ? AppColors.dark : Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCornerBrackets() {
    const bracketSize = 24.0;
    const bracketThickness = 2.5;
    final bracketColor = _isHovered
        ? AppColors.neonBlue.withValues(alpha: 0.7)
        : AppColors.cyberBlue.withValues(alpha: 0.4);

    return [
      // Top Left
      Positioned(
        top: 0,
        left: 0,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _isHovered ? 1.0 : 0.5,
          child: CustomPaint(
            size: const Size(bracketSize, bracketSize),
            painter: _CornerBracketPainter(
              color: bracketColor,
              thickness: bracketThickness,
              isTopLeft: true,
            ),
          ),
        ),
      ),
      // Top Right
      Positioned(
        top: 0,
        right: 0,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _isHovered ? 1.0 : 0.5,
          child: CustomPaint(
            size: const Size(bracketSize, bracketSize),
            painter: _CornerBracketPainter(
              color: bracketColor,
              thickness: bracketThickness,
              isTopRight: true,
            ),
          ),
        ),
      ),
      // Bottom Left
      Positioned(
        bottom: 0,
        left: 0,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _isHovered ? 1.0 : 0.5,
          child: CustomPaint(
            size: const Size(bracketSize, bracketSize),
            painter: _CornerBracketPainter(
              color: bracketColor,
              thickness: bracketThickness,
              isBottomLeft: true,
            ),
          ),
        ),
      ),
      // Bottom Right
      Positioned(
        bottom: 0,
        right: 0,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _isHovered ? 1.0 : 0.5,
          child: CustomPaint(
            size: const Size(bracketSize, bracketSize),
            painter: _CornerBracketPainter(
              color: bracketColor,
              thickness: bracketThickness,
              isBottomRight: true,
            ),
          ),
        ),
      ),
    ];
  }
}

/// ===========================================
/// Corner Bracket Painter for Premium Effect
/// ===========================================
class _CornerBracketPainter extends CustomPainter {
  final Color color;
  final double thickness;
  final bool isTopLeft;
  final bool isTopRight;
  final bool isBottomLeft;
  final bool isBottomRight;

  _CornerBracketPainter({
    required this.color,
    required this.thickness,
    this.isTopLeft = false,
    this.isTopRight = false,
    this.isBottomLeft = false,
    this.isBottomRight = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    if (isTopLeft) {
      canvas.drawLine(Offset(0, size.height), Offset(0, 0), paint);
      canvas.drawLine(Offset(0, 0), Offset(size.width, 0), paint);
    } else if (isTopRight) {
      canvas.drawLine(
        Offset(size.width, size.height),
        Offset(size.width, 0),
        paint,
      );
      canvas.drawLine(Offset(size.width, 0), Offset(0, 0), paint);
    } else if (isBottomLeft) {
      canvas.drawLine(Offset(0, 0), Offset(0, size.height), paint);
      canvas.drawLine(
        Offset(0, size.height),
        Offset(size.width, size.height),
        paint,
      );
    } else if (isBottomRight) {
      canvas.drawLine(
        Offset(size.width, 0),
        Offset(size.width, size.height),
        paint,
      );
      canvas.drawLine(
        Offset(size.width, size.height),
        Offset(0, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
