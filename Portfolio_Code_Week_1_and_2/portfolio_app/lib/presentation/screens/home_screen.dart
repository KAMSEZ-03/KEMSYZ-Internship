import 'package:flutter/material.dart';

// Import widgets
import '../widgets/navbar.dart';

// Import sections
import '../sections/hero.dart';
import '../sections/about.dart';
import '../sections/services.dart';
import '../sections/workflow.dart';
import '../sections/projects.dart';
import '../sections/contact.dart';
import '../sections/footer.dart';

/// Main Portfolio Home Screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _workflowKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final GlobalKey _footerKey = GlobalKey();

  Future<void> _scrollTo(GlobalKey key) async {
    final context = key.currentContext;
    if (context == null) return;

    await Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  void _handleNav(String target) {
    switch (target) {
      case 'home':
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
        break;
      case 'about':
        _scrollTo(_aboutKey);
        break;
      case 'services':
        _scrollTo(_servicesKey);
        break;
      case 'workflow':
        _scrollTo(_workflowKey);
        break;
      case 'projects':
        _scrollTo(_projectsKey);
        break;
      case 'contact':
        _scrollTo(_contactKey);
        break;
      case 'footer':
        _scrollTo(_footerKey);
        break;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  HeroSection(
                    onViewProjects: () => _handleNav('projects'),
                    onContact: () => _handleNav('contact'),
                  ),
                  KeyedSubtree(key: _aboutKey, child: const AboutSection()),
                  KeyedSubtree(
                    key: _servicesKey,
                    child: const ServicesSection(),
                  ),
                  KeyedSubtree(
                    key: _workflowKey,
                    child: const WorkflowSection(),
                  ),
                  KeyedSubtree(
                    key: _projectsKey,
                    child: const ProjectsSection(),
                  ),
                  KeyedSubtree(key: _contactKey, child: const ContactSection()),
                  KeyedSubtree(
                    key: _footerKey,
                    child: FooterSection(onNavSelect: _handleNav),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Navbar(
              scrollController: _scrollController,
              onNavSelect: _handleNav,
              onHireTap: () => _handleNav('contact'),
            ),
          ),
        ],
      ),
    );
  }
}
