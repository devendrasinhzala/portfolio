import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/core/theme/theme.dart';
import 'package:portfolio/core/theme/theme_provider.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/contact_section.dart';

class PortfolioPage extends ConsumerStatefulWidget {
  const PortfolioPage({super.key});

  @override
  ConsumerState<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends ConsumerState<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();
  
  // Section keys for scrolling offsets
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 50) {
      if (!_isScrolled) {
        setState(() => _isScrolled = true);
      }
    } else {
      if (_isScrolled) {
        setState(() => _isScrolled = false);
      }
    }
  }

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, Color primaryColor, bool isDark) {
    final textTheme = Theme.of(context).textTheme;
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 800;

    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _isScrolled
              ? (isDark ? AppTheme.darkBg : AppTheme.lightBg).withAlpha(217)
              : Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: _isScrolled 
                  ? primaryColor.withAlpha(38) 
                  : Colors.transparent,
              width: 1.5,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: AppBar(
          automaticallyImplyLeading: !isDesktop,
          title: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _scrollTo(_heroKey),
              child: Text(
                "DZ.",
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: primaryColor,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
          actions: [
            if (isDesktop) ...[
              _buildNavItem("About", () => _scrollTo(_aboutKey)),
              _buildNavItem("Skills", () => _scrollTo(_skillsKey)),
              _buildNavItem("Work", () => _scrollTo(_projectsKey)),
              _buildNavItem("Experience", () => _scrollTo(_experienceKey)),
              _buildNavItem("Contact", () => _scrollTo(_contactKey)),
              const SizedBox(width: 16),
            ],
            // Theme Toggle Icon
            IconButton(
              icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
              onPressed: () {
                ref.read(themeProvider.notifier).toggleTheme();
              },
              tooltip: "Toggle Theme Mode",
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String label, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: Theme.of(context).textTheme.bodyMedium?.color,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, Color primaryColor, bool isDark) {
    final textTheme = Theme.of(context).textTheme;
    return Drawer(
      backgroundColor: isDark ? AppTheme.darkBg : AppTheme.lightBg,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              "DZ.",
              style: textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w900,
                color: primaryColor,
                fontSize: 40,
              ),
            ),
            const SizedBox(height: 40),
            _buildDrawerItem("Home", () => _scrollTo(_heroKey)),
            _buildDrawerItem("About", () => _scrollTo(_aboutKey)),
            _buildDrawerItem("Skills", () => _scrollTo(_skillsKey)),
            _buildDrawerItem("Work", () => _scrollTo(_projectsKey)),
            _buildDrawerItem("Experience", () => _scrollTo(_experienceKey)),
            _buildDrawerItem("Contact", () => _scrollTo(_contactKey)),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(String label, VoidCallback onTap) {
    return ListTile(
      title: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    final primaryColor = isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentIndigo;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context, primaryColor, isDark),
      drawer: _buildDrawer(context, primaryColor, isDark),
      body: Stack(
        children: [
          // Background Gradient blobs
          Positioned(
            top: -150,
            left: -150,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withAlpha(10),
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            right: -200,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (isDark ? AppTheme.darkAccentIndigo : AppTheme.lightAccentTeal).withAlpha(8),
              ),
            ),
          ),
          // Main Scroll View mapping all portfolio segments
          SelectionArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // Hero Section
                  Container(
                    key: _heroKey,
                    child: HeroSection(
                      onViewWorkPressed: () => _scrollTo(_projectsKey),
                      onContactPressed: () => _scrollTo(_contactKey),
                    ),
                  ),
                  
                  // About Section
                  Container(
                    key: _aboutKey,
                    child: const AboutSection(),
                  ),
                  
                  // Skills Section
                  Container(
                    key: _skillsKey,
                    child: const SkillsSection(),
                  ),
                  
                  // Projects Section
                  Container(
                    key: _projectsKey,
                    child: const ProjectsSection(),
                  ),
                  
                  // Experience Section
                  Container(
                    key: _experienceKey,
                    child: const ExperienceSection(),
                  ),
                  
                  // Contact Section
                  Container(
                    key: _contactKey,
                    child: const ContactSection(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
