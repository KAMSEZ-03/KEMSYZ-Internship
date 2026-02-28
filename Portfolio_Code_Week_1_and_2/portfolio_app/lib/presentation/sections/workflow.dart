import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';

/// ===========================================
/// Workflow Step Data Model
/// ===========================================
class WorkflowStep {
  final IconData icon;
  final String title;
  final String description;
  final String details;

  WorkflowStep({
    required this.icon,
    required this.title,
    required this.description,
    required this.details,
  });
}

/// ===========================================
/// List of Workflow Steps
/// ===========================================
final List<WorkflowStep> steps = [
  WorkflowStep(
    icon: Icons.search,
    title: "Discover",
    description: "Problem Framing & Requirements",
    details:
        "Define goals, stakeholders, constraints, and success metrics to reduce risk early",
  ),
  WorkflowStep(
    icon: Icons.edit,
    title: "Design",
    description: "Architecture & System Design",
    details:
        "Model data flows, scalability, and reliability with clear, maintainable structures",
  ),
  WorkflowStep(
    icon: Icons.layers,
    title: "Build",
    description: "Engineering & Quality",
    details:
        "Implement with clean code, tests, reviews, and performance checks for long-term stability",
  ),
  WorkflowStep(
    icon: Icons.rocket_launch,
    title: "Launch",
    description: "Delivery & Improvement",
    details:
        "Ship, monitor, learn, and iterate to maximize product impact and user value",
  ),
];

/// ===========================================
/// Workflow Section Widget
/// ===========================================
class WorkflowSection extends StatefulWidget {
  const WorkflowSection({super.key});

  @override
  State<WorkflowSection> createState() => _WorkflowSectionState();
}

class _WorkflowSectionState extends State<WorkflowSection>
    with SingleTickerProviderStateMixin {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final isDesktop = screenWidth >= 1200;
    final double singleCardWidth = (screenWidth - 48).clamp(240.0, 520.0);
    final cardWidth = screenWidth < 800
        ? singleCardWidth
        : (screenWidth < 1200
              ? (screenWidth - 86) / 2
              : (screenWidth - 120) / 4);

    return Container(
      color: AppColors.dark,
      padding: const EdgeInsets.symmetric(vertical: 96, horizontal: 24),
      child: Stack(
        children: [
          // ===========================================
          // Content
          // ===========================================
          Column(
            children: [
              // ===========================================
              // Section Header
              // ===========================================
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.charcoal,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: AppColors.cyberBlue.withValues(alpha: 0.3),
                      ),
                    ),
                    child: const Text(
                      "HOW WE WORK",
                      style: TextStyle(
                        color: AppColors.cyberBlue,
                        letterSpacing: 1.5,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Software engineering workflow",
                    style: AppText.h2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Text(
                      "Applying engineering principles, clear architecture, and iterative delivery to build reliable, maintainable, and impactful products",
                      textAlign: TextAlign.center,
                      style: AppText.body,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 72),

              // ===========================================
              // Workflow Steps
              // ===========================================
              Stack(
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 24,
                    runSpacing: 24,
                    children: List.generate(steps.length, (index) {
                      final step = steps[index];
                      final isHovered = _hoveredIndex == index;

                      return MouseRegion(
                        onEnter: (_) => setState(() {
                          _hoveredIndex = index;
                        }),
                        onExit: (_) => setState(() {
                          if (_hoveredIndex == index) {
                            _hoveredIndex = null;
                          }
                        }),
                        child: AnimatedScale(
                          scale: isHovered ? 1.02 : 1.0,
                          duration: const Duration(milliseconds: 200),
                          child: SizedBox(
                            width: cardWidth,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                // ===========================================
                                // Step Card
                                // ===========================================
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.only(
                                    top: 40,
                                    left: 24,
                                    right: 24,
                                    bottom: 24,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.charcoal.withValues(
                                          alpha: 0.9,
                                        ),
                                        AppColors.charcoal.withValues(
                                          alpha: 0.6,
                                        ),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: isHovered
                                          ? AppColors.cyberBlue.withValues(
                                              alpha: 0.6,
                                            )
                                          : AppColors.cyberBlue.withValues(
                                              alpha: 0.25,
                                            ),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: isHovered
                                            ? AppColors.cyberBlue.withValues(
                                                alpha: 0.18,
                                              )
                                            : Colors.black.withValues(
                                                alpha: 0.25,
                                              ),
                                        blurRadius: isHovered ? 22 : 16,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      // Icon
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColors.cyberBlue.withValues(
                                                alpha: 0.25,
                                              ),
                                              AppColors.neonBlue.withValues(
                                                alpha: 0.18,
                                              ),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          border: Border.all(
                                            color: AppColors.cyberBlue
                                                .withValues(alpha: 0.4),
                                          ),
                                          boxShadow: isHovered
                                              ? [
                                                  BoxShadow(
                                                    color: AppColors.cyberBlue
                                                        .withValues(alpha: 0.2),
                                                    blurRadius: 14,
                                                  ),
                                                ]
                                              : [],
                                        ),
                                        child: Icon(
                                          step.icon,
                                          color: AppColors.cyberBlue,
                                          size: 40,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        step.title,
                                        textAlign: TextAlign.center,
                                        style: AppText.h3,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        step.description,
                                        textAlign: TextAlign.center,
                                        style: AppText.body.copyWith(
                                          color: AppColors.cyberBlue,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        step.details,
                                        textAlign: TextAlign.center,
                                        style: AppText.body.copyWith(
                                          fontSize: 15,
                                          height: 1.6,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // ===========================================
                                // Step Number Badge
                                // ===========================================
                                Positioned(
                                  top: -16,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: AppColors.charcoal,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: AppColors.cyberBlue,
                                          width: 2,
                                        ),
                                        boxShadow: isHovered
                                            ? [
                                                BoxShadow(
                                                  color: AppColors.cyberBlue
                                                      .withValues(alpha: 0.2),
                                                  blurRadius: 10,
                                                ),
                                              ]
                                            : [],
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${index + 1}",
                                          style: const TextStyle(
                                            color: AppColors.cyberBlue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // ===========================================
                                // Arrow Indicator (Desktop Only)
                                // ===========================================
                                // if (isDesktop && index < steps.length - 1)
                                //   Positioned(
                                //     top: 44,
                                //     right: -22,
                                //     child: Container(
                                //       padding: const EdgeInsets.symmetric(
                                //         horizontal: 6,
                                //         vertical: 4,
                                //       ),
                                //       decoration: BoxDecoration(
                                //         color: AppColors.charcoal,
                                //         borderRadius: BorderRadius.circular(12),
                                //         border: Border.all(
                                //           color: AppColors.cyberBlue
                                //               .withOpacity(0.5),
                                //         ),
                                //         boxShadow: [
                                //           BoxShadow(
                                //             color: AppColors.cyberBlue
                                //                 .withOpacity(0.15),
                                //             blurRadius: 8,
                                //           ),
                                //         ],
                                //       ),
                                //       child: Icon(
                                //         Icons.arrow_right_alt_rounded,
                                //         size: 18,
                                //         color: AppColors.cyberBlue.withOpacity(
                                //           0.9,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),

              const SizedBox(height: 48),

              // ===========================================
              // Process Metrics
              // ===========================================
              // Wrap(
              //   alignment: WrapAlignment.center,
              //   spacing: 16,
              //   runSpacing: 12,
              //   children: [
              //     _MetricChip(label: "Average Processing", value: "24-48 hrs"),
              //     _MetricChip(label: "Priority Rush", value: "6 hrs"),
              //   ],
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

//  class _MetricChip extends StatelessWidget {
//   final String label;
//   final String value;

//   const _MetricChip({required this.label, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       decoration: BoxDecoration(
//         color: AppColors.charcoal,
//         borderRadius: BorderRadius.circular(999),
//         border: Border.all(color: AppColors.cyberBlue.withOpacity(0.3)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: 8,
//             height: 8,
//             decoration: BoxDecoration(
//               color: Colors.greenAccent.withOpacity(0.9),
//               shape: BoxShape.circle,
//             ),
//           ),
//           const SizedBox(width: 8),
//           Text(
//             "$label: ",
//             style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 12),
//           ),
//           Text(
//             value,
//             style: const TextStyle(
//               color: AppColors.cyberBlue,
//               fontSize: 12,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
