import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 96, horizontal: 24),
      color: AppColors.dark,
      child: Stack(
        children: [
          /// Background Blobs
          Positioned.fill(child: _BackgroundBlobs()),

          /// Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const _Header(),
                const SizedBox(height: 64),
                const _StrengthGrid(),
              ],
            ),
          ),
        ],
      ),
      //  ],
      // ),
    );
  }
}

class _BackgroundBlobs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: MediaQuery.of(context).size.width * 0.25,
          child: _glow(AppColors.cyberBlue),
        ),
        Positioned(
          bottom: 0,
          right: MediaQuery.of(context).size.width * 0.25,
          child: _glow(AppColors.accentPurple),
        ),
      ],
    );
  }

  Widget _glow(Color color) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 120,
            spreadRadius: 20,
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.charcoal,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: AppColors.cyberBlue.withValues(alpha: 0.3),
            ),
          ),
          child: Text(
            "ABOUT ME",
            style: TextStyle(color: AppColors.cyberBlue, letterSpacing: 1.5),
          ),
        ),
        const SizedBox(height: 24),

        /// Title
        Text(
          "I turn ideas into digital products that deliver real value.",
          style: AppText.h2,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 24),

        /// Description
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Text(
            "I’m a web and Flutter mobile developer focused on building high-performance, scalable digital products. "
            "From modern front-end interfaces to full-stack systems and cross-platform mobile apps, "
            "I create fast, accessible, and thoughtfully designed experiences that help teams move from idea to impact.",
            style: AppText.body,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class Strength {
  final IconData icon;
  final String title;
  final String description;

  Strength(this.icon, this.title, this.description);
}

final strengths = [
  Strength(
    Icons.psychology,
    "Strategic Problem Solver",
    "I translate complex, ambiguous requirements into elegant, scalable solutions with clear trade-offs.",
  ),
  Strength(
    Icons.shield,
    "Secure by Design",
    "Security, performance, and accessibility are built in from day one—not patched in later.",
  ),
  Strength(
    Icons.layers,
    "Software Engineering Discipline",
    "Strong foundations in system design, data structures, clean architecture, and maintainable codebases.",
  ),
  Strength(
    Icons.memory,
    "AI Generalist Mindset",
    "I apply machine learning, data-driven thinking, and intelligent automation where they create real value.",
  ),
  Strength(
    Icons.flash_on,
    "Rapid Execution",
    "Fast prototyping, tight feedback loops, and iterative delivery to move ideas into production.",
  ),
  Strength(
    Icons.workspace_premium,
    "Quality & Craftsmanship",
    "Readable code, resilient systems, and long-term thinking over short-term hacks.",
  ),
];

class _StrengthGrid extends StatelessWidget {
  const _StrengthGrid();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    int columns = 1;
    if (width > 1024) {
      columns = 3;
    } else if (width > 768) {
      columns = 2;
    }

    return Column(
      children: [
        Text("Why Work With Me", style: AppText.h3),
        const SizedBox(height: 48),
        if (isMobile)
          Column(
            children: [
              for (final item in strengths) ...[
                _StrengthCard(item),
                const SizedBox(height: 16),
              ],
            ],
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: strengths.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: columns == 1 ? 2.8 : (columns == 2 ? 2.0 : 1.8),
            ),
            itemBuilder: (_, i) => _StrengthCard(strengths[i]),
          ),
      ],
    );
  }
}

class _StrengthCard extends StatefulWidget {
  final Strength strength;
  const _StrengthCard(this.strength);

  @override
  State<_StrengthCard> createState() => _StrengthCardState();
}

class _StrengthCardState extends State<_StrengthCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.charcoal.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.cyberBlue.withValues(alpha: hovered ? 0.5 : 0.2),
          ),
          boxShadow: hovered
              ? [
                  BoxShadow(
                    color: AppColors.cyberBlue.withValues(alpha: 0.1),
                    blurRadius: 20,
                  ),
                ]
              : [],
        ),
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Icon Box
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.cyberBlue.withValues(alpha: 0.2),
                          AppColors.neonBlue.withValues(alpha: 0.2),
                        ],
                      ),
                      border: Border.all(
                        color: AppColors.cyberBlue.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Icon(
                      widget.strength.icon,
                      color: AppColors.cyberBlue,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 10),

                  /// Text
                  Text(
                    widget.strength.title,
                    style: AppText.h3.copyWith(fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.strength.description,
                    style: AppText.body.copyWith(fontSize: 14),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Icon Box
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.cyberBlue.withValues(alpha: 0.2),
                          AppColors.neonBlue.withValues(alpha: 0.2),
                        ],
                      ),
                      border: Border.all(
                        color: AppColors.cyberBlue.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Icon(
                      widget.strength.icon,
                      color: AppColors.cyberBlue,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),

                  /// Text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.strength.title,
                          style: AppText.h3.copyWith(fontSize: 16),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.strength.description,
                          style: AppText.body.copyWith(fontSize: 14),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
