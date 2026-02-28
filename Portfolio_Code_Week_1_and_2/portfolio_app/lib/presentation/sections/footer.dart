import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/theme/app_colors.dart';

/// ===========================================
/// Portfolio Footer Widget
/// Converted from React → Flutter
/// ===========================================
class FooterSection extends StatelessWidget {
  final void Function(String target) onNavSelect;

  const FooterSection({super.key, required this.onNavSelect});

  // ===========================================
  // Helper function to open links
  // ===========================================
  Future<void> _openLink(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth < 900;

    final horizontalPadding = isMobile
        ? 16.0
        : isTablet
        ? 24.0
        : 32.0;
    final verticalPadding = isMobile ? 32.0 : 48.0;
    final sectionSpacing = isMobile ? 24.0 : 48.0;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.dark,
        border: Border(
          top: BorderSide(
            color: AppColors.cyberBlue.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Main Footer Content
            Container(
              constraints: const BoxConstraints(maxWidth: 1280),
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===========================================
                  // TOP GRID SECTION
                  // Company Info + Services + Links
                  // ===========================================
                  isMobile
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _topSections(context, true),
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _topSections(context, false),
                        ),

                  SizedBox(height: sectionSpacing),

                  // ===========================================
                  // DIVIDER LINE
                  // ===========================================
                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppColors.cyberBlue.withValues(alpha: 0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: isMobile ? 20.0 : 32.0),

                  // ===========================================
                  // SOCIAL MEDIA + COPYRIGHT ROW
                  // ===========================================
                  isMobile
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _socialIcons(),
                            SizedBox(height: isMobile ? 20.0 : 24.0),
                            _copyright(isMobile),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [_socialIcons(), _copyright(false)],
                        ),

                  SizedBox(height: isMobile ? 24.0 : 32.0),

                  // ===========================================
                  // AVAILABILITY NOTE BOX
                  // ===========================================
                  Container(
                    padding: EdgeInsets.all(isMobile ? 16 : 20),
                    decoration: BoxDecoration(
                      color: AppColors.charcoal.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.cyberBlue.withValues(alpha: 0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.cyberBlue.withValues(alpha: 0.05),
                          blurRadius: 20,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withValues(alpha: 0.5),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: isMobile ? 10 : 12),
                        Flexible(
                          child: Text(
                            "Open to freelance, contract, and part-time opportunities.",
                            style: TextStyle(
                              color: const Color(0xFFCBD5E1),
                              fontSize: isMobile ? 13 : 14,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ===========================================
            // BOTTOM ANIMATED GRADIENT LINE
            // ===========================================
            Container(
              height: 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    AppColors.cyberBlue,
                    AppColors.neonBlue,
                    AppColors.cyberBlue,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================
  // TOP SECTIONS BUILDER
  // ===========================================
  List<Widget> _topSections(BuildContext context, bool isMobile) {
    final spacing = isMobile ? 24.0 : 48.0;
    final horizontalSpacing = isMobile ? 32.0 : 48.0;

    if (isMobile) {
      return [
        _companyInfo(context),
        SizedBox(height: spacing),
        _services(context),
        SizedBox(height: spacing),
        _links(context),
      ];
    }

    return [
      Expanded(flex: 2, child: _companyInfo(context)),
      SizedBox(width: horizontalSpacing),
      Expanded(child: _services(context)),
      SizedBox(width: horizontalSpacing),
      Expanded(child: _links(context)),
    ];
  }

  // ===========================================
  // COMPANY INFO SECTION
  // ===========================================
  Widget _companyInfo(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final logoSize = isMobile ? 40.0 : 48.0;
    final iconSize = isMobile ? 20.0 : 26.0;
    final nameFontSize = isMobile ? 14.0 : 16.0;
    final descFontSize = isMobile ? 13.0 : 14.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo and Brand
        Row(
          children: [
            Container(
              width: logoSize,
              height: logoSize,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.cyberBlue, AppColors.neonBlue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cyberBlue.withValues(alpha: 0.3),
                    blurRadius: 12,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Icon(
                Icons.code,
                color: const Color(0xFF0A1628),
                size: iconSize,
              ),
            ),
            SizedBox(width: isMobile ? 10 : 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Muhammad Khurram",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: nameFontSize,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Portfolio",
                    style: TextStyle(
                      color: const Color(0xFF00D4FF),
                      fontSize: isMobile ? 11 : 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: isMobile ? 12 : 16),

        // Description
        Text(
          "I engineer modern web and mobile applications with clean architecture, performance, and accessibility at the core.",
          style: TextStyle(
            color: const Color(0xFF94A3B8),
            fontSize: descFontSize,
            height: 1.6,
            letterSpacing: 0.2,
          ),
        ),
        SizedBox(height: isMobile ? 12 : 16),

        // Availability Status
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withValues(alpha: 0.4),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "Available for new projects",
              style: TextStyle(
                color: const Color(0xFF64748B),
                fontSize: isMobile ? 12 : 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ===========================================
  // SERVICES SECTION
  // ===========================================
  Widget _services(BuildContext context) {
    return _footerColumn(context, "Services", const [
      _FooterItem("Web App Development"),
      _FooterItem("Mobile App Development"),
      _FooterItem("E-commerce and SaaS"),
    ]);
  }

  // ===========================================
  // LINKS SECTION
  // ===========================================
  Widget _links(BuildContext context) {
    return _footerColumn(context, "Links", const [
      _FooterItem("About", target: "about"),
      _FooterItem("Projects", target: "projects"),
      _FooterItem("Workflow", target: "workflow"),
      _FooterItem("Contact", target: "contact"),
    ], onItemTap: onNavSelect);
  }

  // ===========================================
  // REUSABLE FOOTER COLUMN
  // ===========================================
  Widget _footerColumn(
    BuildContext context,
    String title,
    List<_FooterItem> items, {
    void Function(String target)? onItemTap,
  }) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final titleFontSize = isMobile ? 14.0 : 16.0;
    final itemFontSize = isMobile ? 13.0 : 14.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: titleFontSize,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
        SizedBox(height: isMobile ? 12 : 16),
        ...items.map((item) {
          final isClickable = item.target != null && onItemTap != null;
          return Padding(
            padding: EdgeInsets.only(bottom: isMobile ? 8 : 10),
            child: MouseRegion(
              cursor: isClickable
                  ? SystemMouseCursors.click
                  : SystemMouseCursors.basic,
              child: GestureDetector(
                onTap: isClickable ? () => onItemTap(item.target!) : null,
                child: Text(
                  item.label,
                  style: TextStyle(
                    color: const Color(0xFF94A3B8),
                    fontSize: itemFontSize,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  // ===========================================
  // SOCIAL ICONS ROW
  // ===========================================
  Widget _socialIcons() {
    return Row(
      children: [
        _iconButton(FontAwesomeIcons.xTwitter, "https://x.com/KAMSEZ"),
        const SizedBox(width: 12),
        _iconButton(
          FontAwesomeIcons.linkedin,
          "https://www.linkedin.com/in/khurram-shehzad-0a207b253/",
        ),
        const SizedBox(width: 12),
        _iconButton(FontAwesomeIcons.github, "https://github.com/KAMSEZ-03"),
        const SizedBox(width: 12),
        _iconButton(FontAwesomeIcons.envelope, "mailto:kemsyz.labs@email.com"),
      ],
    );
  }

  // ===========================================
  // INDIVIDUAL SOCIAL BUTTON
  // ===========================================
  Widget _iconButton(IconData icon, String url) {
    return InkWell(
      onTap: () => _openLink(url),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.charcoal,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.cyberBlue.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Icon(icon, color: AppColors.cyberBlue, size: 20),
      ),
    );
  }

  // ===========================================
  // COPYRIGHT TEXT
  // ===========================================
  Widget _copyright(bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.end,
      children: [
        Text(
          "© 2026 KEMSYZ-LABS. All rights reserved.",
          style: TextStyle(
            color: const Color(0xFF94A3B8),
            fontSize: isMobile ? 12 : 14,
            fontWeight: FontWeight.w400,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.right,
        ),
        const SizedBox(height: 4),
        Text(
          "Built with Flutter & ❤️",
          style: TextStyle(
            color: const Color(0xFF64748B),
            fontSize: isMobile ? 11 : 12,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.3,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.right,
        ),
      ],
    );
  }
}

class _FooterItem {
  final String label;
  final String? target;

  const _FooterItem(this.label, {this.target});
}
