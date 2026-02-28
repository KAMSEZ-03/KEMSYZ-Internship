import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// ===========================================
/// Navbar Widget
/// Converted from React → Flutter
/// ===========================================
class Navbar extends StatefulWidget {
  final ScrollController scrollController;
  final void Function(String target) onNavSelect;
  final VoidCallback onHireTap;

  const Navbar({
    super.key,
    required this.scrollController,
    required this.onNavSelect,
    required this.onHireTap,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  // ===========================================
  // STATE VARIABLES
  // ===========================================
  bool _isMobileMenuOpen = false;

  // Navigation items
  final List<Map<String, String>> _navItems = [
    {'label': 'Home', 'target': 'home'},
    {'label': 'About', 'target': 'about'},
    {'label': 'Services', 'target': 'services'},
    {'label': 'Workflow', 'target': 'workflow'},
    {'label': 'Projects', 'target': 'projects'},
    {'label': 'Contact', 'target': 'contact'},
  ];

  @override
  void initState() {
    super.initState();
    // No need to listen to scroll anymore as navbar is always opaque
  }

  @override
  void didUpdateWidget(covariant Navbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // No scroll listener needed
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleNavTap(String target) {
    widget.onNavSelect(target);
    if (_isMobileMenuOpen) {
      setState(() => _isMobileMenuOpen = false);
    }
  }

  void _handleHireTap() {
    widget.onHireTap();
    if (_isMobileMenuOpen) {
      setState(() => _isMobileMenuOpen = false);
    }
  }

  // ===========================================
  // LISTEN TO SCROLL TO CHANGE BACKGROUND
  // ===========================================
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final showMobileMenu =
        screenWidth < 1024; // Show menu for tablets and mobile

    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: [
          // ===========================================
          // NAVBAR CONTAINER
          // ===========================================
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: AppColors.navy,
              // color: AppColors.dark,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.cyberBlue.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, isMobile ? 32 : 12, 16, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ===========================================
                  // LOGO
                  // ===========================================
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Show logo only on larger screens
                      if (!isMobile) ...[
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppColors.cyberBlue, AppColors.neonBlue],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Icon(Icons.code, color: Colors.black87),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                      // Show name on all screens
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isMobile
                                ? "MK Shehzad"
                                : "Muhammad Khurram Shehzad",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          const Text(
                            "Portfolio",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.cyberBlue,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // ===========================================
                  // DESKTOP NAVIGATION (Only for large screens)
                  // ===========================================
                  if (!showMobileMenu)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (var item in _navItems)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: TextButton(
                              onPressed: () => _handleNavTap(item['target']!),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white70,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                              child: Text(
                                item['label']!,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: _handleHireTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.cyberBlue,
                            foregroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Hire Me",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),

                  // ===========================================
                  // MOBILE/TABLET MENU BUTTON
                  // ===========================================
                  if (showMobileMenu)
                    IconButton(
                      icon: Icon(
                        _isMobileMenuOpen ? Icons.close : Icons.menu,
                        color: AppColors.cyberBlue,
                      ),
                      onPressed: () {
                        setState(() {
                          _isMobileMenuOpen = !_isMobileMenuOpen;
                        });
                      },
                    ),
                ],
              ),
            ),
          ),

          // ===========================================
          // MOBILE MENU
          // ===========================================
          if (_isMobileMenuOpen && showMobileMenu)
            Container(
              color: AppColors.dark,
              child: Column(
                children: [
                  for (var item in _navItems)
                    ListTile(
                      title: Text(
                        item['label']!,
                        style: const TextStyle(color: Colors.white70),
                      ),
                      onTap: () => _handleNavTap(item['target']!),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ElevatedButton(
                      onPressed: _handleHireTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.cyberBlue,
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Hire Me"),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
