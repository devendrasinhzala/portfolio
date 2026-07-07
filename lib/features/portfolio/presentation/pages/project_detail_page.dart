import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../data/portfolio_data.dart';

class ProjectDetailPage extends ConsumerStatefulWidget {
  final Project project;

  const ProjectDetailPage({
    super.key,
    required this.project,
  });

  @override
  ConsumerState<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends ConsumerState<ProjectDetailPage> {
  int _activeSlideIndex = 0;
  bool _isHoveredGit = false;
  bool _isHoveredDemo = false;
  bool _isNavigatingNext = true;

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    final textTheme = Theme.of(context).textTheme;
    final accentColor = isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentIndigo;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: "Back to Portfolio",
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/projects');
            }
          },
        ),
        title: Text(widget.project.title),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
            tooltip: "Toggle Theme Mode",
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Stack(
        children: [
          // Background Glows
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accentColor.withOpacity(0.04),
              ),
            ),
          ),
          
          SelectionArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isDesktop = constraints.maxWidth > 850;
                      if (isDesktop) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child: _buildDetailsContent(textTheme, accentColor, isDark),
                            ),
                            const SizedBox(width: 60),
                            Expanded(
                              flex: 4,
                              child: _buildScreenshotSlideshow(accentColor, isDark),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildScreenshotSlideshow(accentColor, isDark),
                            const SizedBox(height: 50),
                            _buildDetailsContent(textTheme, accentColor, isDark),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsContent(TextTheme textTheme, Color accentColor, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title banner
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: widget.project.gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(Offset.zero & bounds.size),
          child: Text(
            widget.project.title,
            style: textTheme.displayMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // Tech Badge Wrap
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.project.technologies.map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: accentColor.withOpacity(0.15),
                ),
              ),
              child: Text(
                tech,
                style: textTheme.labelSmall?.copyWith(
                  color: accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 32),
        
        // Extended About description
        Text(
          "About the Project",
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          widget.project.detailedDescription,
          style: textTheme.bodyLarge?.copyWith(
            color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
            height: 1.8,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 32),
        
        // Features list bullet points
        Text(
          "Key Features",
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...widget.project.features.map((feature) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6.0, right: 12.0),
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: accentColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    feature,
                    style: textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                      color: isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        const SizedBox(height: 48),
        
        // Actions Links
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            // Code Link
            MouseRegion(
              onEnter: (_) => setState(() => _isHoveredGit = true),
              onExit: (_) => setState(() => _isHoveredGit = false),
              child: AnimatedScale(
                scale: _isHoveredGit ? 1.05 : 1.0,
                duration: const Duration(milliseconds: 150),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: _isHoveredGit && isDark
                        ? [
                            BoxShadow(
                              color: accentColor.withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            )
                          ]
                        : null,
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () => _launchUrl(widget.project.githubUrl),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                      backgroundColor: isDark ? AppTheme.darkCardBg : AppTheme.lightAccentIndigo,
                      foregroundColor: Colors.white,
                      side: BorderSide(
                        color: accentColor.withOpacity(0.3),
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    icon: const FaIcon(FontAwesomeIcons.github, size: 20),
                    label: const Text("View Code Repository", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
            
            // Demo Link
            MouseRegion(
              onEnter: (_) => setState(() => _isHoveredDemo = true),
              onExit: (_) => setState(() => _isHoveredDemo = false),
              child: AnimatedScale(
                scale: _isHoveredDemo ? 1.05 : 1.0,
                duration: const Duration(milliseconds: 150),
                child: OutlinedButton.icon(
                  onPressed: () => _launchUrl(widget.project.demoUrl),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                    foregroundColor: accentColor,
                    side: BorderSide(color: accentColor, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: const Icon(Icons.open_in_new_rounded, size: 20),
                  label: const Text("Launch Live Demo", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildScreenshotSlideshow(Color accentColor, bool isDark) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Previous Slide Button
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                setState(() {
                  _isNavigatingNext = false;
                  _activeSlideIndex = (_activeSlideIndex - 1 + widget.project.screenshots.length) % widget.project.screenshots.length;
                });
              },
              tooltip: "Previous Screenshot",
            ),
            const SizedBox(width: 12),
            
            // Interactive Phone Container device mockup
            Container(
              width: 300,
              height: 600,
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkBg : Colors.white,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color: (isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary).withOpacity(0.3),
                  width: 8,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.4 : 0.1),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                children: [
                  // Phone Notch Ear Speaker
                  Container(
                    width: 70,
                    height: 18,
                    decoration: BoxDecoration(
                      color: (isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(bottom: 16.0),
                  ),
                  
                  // Swappable Slide Content View with direction-aware transitions
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 350),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          final offsetBegin = _isNavigatingNext 
                              ? const Offset(0.3, 0.0) 
                              : const Offset(-0.3, 0.0);
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: offsetBegin,
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeInOutCubic,
                                ),
                              ),
                              child: child,
                            ),
                          );
                        },
                        child: _buildMockScreen(context, _activeSlideIndex, isDark, accentColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: 12),
            // Next Slide Button
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios_rounded),
              onPressed: () {
                setState(() {
                  _isNavigatingNext = true;
                  _activeSlideIndex = (_activeSlideIndex + 1) % widget.project.screenshots.length;
                });
              },
              tooltip: "Next Screenshot",
            ),
          ],
        ),
        const SizedBox(height: 30),
        
        // Dynamic horizontal preview thumbnails of mockup screens
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.project.screenshots.length, (index) {
            final isActive = _activeSlideIndex == index;
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  if (index == _activeSlideIndex) return;
                  setState(() {
                    _isNavigatingNext = index > _activeSlideIndex;
                    _activeSlideIndex = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  width: 55,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isActive ? accentColor : Colors.grey.withOpacity(0.3),
                      width: isActive ? 2.5 : 1.5,
                    ),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: accentColor.withOpacity(0.25),
                              blurRadius: 8,
                              spreadRadius: 1,
                            )
                          ]
                        : null,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Opacity(
                      opacity: isActive ? 1.0 : 0.65,
                      child: AbsorbPointer(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: 284,
                            height: 550,
                            child: _buildMockScreen(context, index, isDark, accentColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildMockScreen(BuildContext context, int slideIndex, bool isDark, Color accentColor) {
    // Return uniquely styled premium mockup templates representing screenshots
    final textTheme = Theme.of(context).textTheme;

    switch (slideIndex) {
      case 0:
        return Container(
          key: ValueKey<int>(slideIndex),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.project.gradientColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.dashboard_outlined, color: Colors.white, size: 24),
                  CircleAvatar(radius: 12, backgroundColor: Colors.white24, child: Icon(Icons.person, size: 12, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                "${widget.project.title}\nDashboard",
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22, height: 1.2),
              ),
              const SizedBox(height: 20),
              // Dummy summary card
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.show_chart, color: Colors.white, size: 20)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("App Analytics", style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text("+24.5% Active Users", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Mock stats list
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: (isDark ? AppTheme.darkCardBg : Colors.white).withOpacity(0.95), borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      _buildMockScreenListItem(Icons.cloud_done, "Sync Status", "Completed", isDark),
                      const Divider(height: 12),
                      _buildMockScreenListItem(Icons.security, "SSL Secure", "Active", isDark),
                      const Divider(height: 12),
                      _buildMockScreenListItem(Icons.storage, "API Sync", "9.2 ms latency", isDark),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      case 1:
        return Container(
          key: ValueKey<int>(slideIndex),
          color: isDark ? AppTheme.darkCardBg : Colors.grey[50],
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back_ios_new, color: accentColor, size: 20),
                  Text("System Analysis", style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
                  Icon(Icons.more_vert, color: accentColor, size: 20),
                ],
              ),
              const SizedBox(height: 30),
              // Big Value Counter Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: AppTheme.darkHeroGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("RESPONSE METRIC", style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                    SizedBox(height: 6),
                    Text("99.98%", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900)),
                    SizedBox(height: 6),
                    Text("Uptime SLA guarantee active", style: TextStyle(color: Colors.white70, fontSize: 11)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text("PERFORMANCE SCORES", style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Expanded(
                child: Column(
                  children: [
                    _buildMockProgressRow("API Fetch Latency", 0.9, accentColor),
                    const SizedBox(height: 12),
                    _buildMockProgressRow("Isolate calculations", 0.85, accentColor),
                    const SizedBox(height: 12),
                    _buildMockProgressRow("UI Frame rate (FPS)", 0.98, accentColor),
                  ],
                ),
              ),
            ],
          ),
        );
      default:
        return Container(
          key: ValueKey<int>(slideIndex),
          color: isDark ? AppTheme.darkCardBg : Colors.grey[50],
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.settings, color: accentColor, size: 24),
                  const SizedBox(width: 10),
                  Text("Settings", style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
              const SizedBox(height: 35),
              _buildMockToggleRow("Local Offline DB cache", true, accentColor, isDark),
              const Divider(height: 24),
              _buildMockToggleRow("Background syncing", true, accentColor, isDark),
              const Divider(height: 24),
              _buildMockToggleRow("Push notifications", false, accentColor, isDark),
              const Divider(height: 24),
              _buildMockToggleRow("Debug Console Logs", false, accentColor, isDark),
            ],
          ),
        );
    }
  }

  Widget _buildMockScreenListItem(IconData icon, String title, String val, bool isDark) {
    return Row(
      children: [
        Icon(icon, size: 16, color: isDark ? Colors.white60 : Colors.black54),
        const SizedBox(width: 8),
        Expanded(child: Text(title, style: TextStyle(fontSize: 11, color: isDark ? Colors.white70 : Colors.black87, fontWeight: FontWeight.w600))),
        Text(val, style: TextStyle(fontSize: 11, color: isDark ? Colors.white54 : Colors.black54)),
      ],
    );
  }

  Widget _buildMockProgressRow(String label, double val, Color accentColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            Text("${(val * 100).toInt()}%", style: TextStyle(fontSize: 11, color: accentColor, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: val,
            minHeight: 5,
            backgroundColor: accentColor.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(accentColor),
          ),
        ),
      ],
    );
  }

  Widget _buildMockToggleRow(String label, bool active, Color accentColor, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isDark ? Colors.white : Colors.black87)),
        Switch(
          value: active,
          onChanged: (_) {},
          activeColor: accentColor,
        ),
      ],
    );
  }
}
