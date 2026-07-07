import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/theme.dart';
import '../../data/portfolio_data.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onViewWorkPressed;
  final VoidCallback onContactPressed;

  const HeroSection({
    super.key,
    required this.onViewWorkPressed,
    required this.onContactPressed,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  bool _isHoveredView = false;
  bool _isHoveredContact = false;

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (_) {
      // Gracefully handle or log error
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      constraints: BoxConstraints(minHeight: size.height * 0.85),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
      alignment: Alignment.center,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 800;

          if (isDesktop) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: _buildIntroContent(textTheme, isDark),
                ),
                const SizedBox(width: 40),
                Expanded(
                  flex: 4,
                  child: _buildVisualGraphic(isDark),
                ),
              ],
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildVisualGraphic(isDark),
                const SizedBox(height: 40),
                _buildIntroContent(textTheme, isDark, alignCenter: true),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildIntroContent(TextTheme textTheme, bool isDark, {bool alignCenter = false}) {
    final personal = PortfolioData.personalInfo;
    final crossAlign = alignCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textWidgetAlign = alignCenter ? TextAlign.center : TextAlign.left;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAlign,
      children: [
        // Tagline / Greeting
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: (isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentTeal).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: (isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentTeal).withOpacity(0.2),
            ),
          ),
          child: Text(
            "Hello World, I'm",
            style: textTheme.labelLarge?.copyWith(
              color: isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentTeal,
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Name
        Text(
          personal.name,
          textAlign: textWidgetAlign,
          style: textTheme.displayLarge?.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: alignCenter ? 36 : 56,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 12),
        // Subtitle with gradient
        ShaderMask(
          shaderCallback: (bounds) => (isDark ? AppTheme.darkHeroGradient : AppTheme.lightHeroGradient)
              .createShader(Offset.zero & bounds.size),
          child: Text(
            personal.title,
            textAlign: textWidgetAlign,
            style: textTheme.displayMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: alignCenter ? 24 : 32,
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Short Bio
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            personal.bio,
            textAlign: textWidgetAlign,
            style: textTheme.bodyLarge?.copyWith(
              color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 32),
        // Social Row
        Row(
          mainAxisAlignment: alignCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            _buildSocialIcon(FontAwesomeIcons.github, personal.github),
            const SizedBox(width: 20),
            _buildSocialIcon(FontAwesomeIcons.linkedin, personal.linkedin),
            const SizedBox(width: 20),
            _buildSocialIcon(FontAwesomeIcons.twitter, personal.twitter),
            const SizedBox(width: 20),
            _buildSocialIcon(FontAwesomeIcons.envelope, "mailto:${personal.email}"),
          ],
        ),
        const SizedBox(height: 40),
        // Buttons
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: alignCenter ? WrapAlignment.center : WrapAlignment.start,
          children: [
            // Primary CTA
            MouseRegion(
              onEnter: (_) => setState(() => _isHoveredView = true),
              onExit: (_) => setState(() => _isHoveredView = false),
              child: AnimatedScale(
                scale: _isHoveredView ? 1.05 : 1.0,
                duration: const Duration(milliseconds: 150),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: _isHoveredView && isDark
                        ? [
                            BoxShadow(
                              color: AppTheme.darkAccentTeal.withOpacity(0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 5),
                            )
                          ]
                        : null,
                  ),
                  child: ElevatedButton(
                    onPressed: widget.onViewWorkPressed,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                      backgroundColor: isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentIndigo,
                      foregroundColor: isDark ? AppTheme.darkBg : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text("View My Work", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward_rounded, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Secondary CTA
            MouseRegion(
              onEnter: (_) => setState(() => _isHoveredContact = true),
              onExit: (_) => setState(() => _isHoveredContact = false),
              child: AnimatedScale(
                scale: _isHoveredContact ? 1.05 : 1.0,
                duration: const Duration(milliseconds: 150),
                child: OutlinedButton(
                  onPressed: widget.onContactPressed,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                    foregroundColor: isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentIndigo,
                    side: BorderSide(
                      color: isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentIndigo,
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text("Get In Touch", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon(FaIconData icon, String url) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchUrl(url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (isDark ? AppTheme.darkCardBg : AppTheme.lightCardBg),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: (isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentIndigo).withOpacity(0.15),
            ),
          ),
          child: FaIcon(
            icon,
            size: 20,
            color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildVisualGraphic(bool isDark) {
    // Beautiful layered floating container
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(seconds: 1),
      builder: (context, val, child) {
        return Opacity(
          opacity: val,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - val)),
            child: child,
          ),
        );
      },
      child: Center(
        child: SizedBox(
          width: 320,
          height: 320,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer glow circle 1 (indigo)
              AnimatedContainer(
                duration: const Duration(seconds: 3),
                curve: Curves.easeInOut,
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      (isDark ? AppTheme.darkAccentIndigo : AppTheme.lightAccentIndigo).withOpacity(0.18),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              // Outer glow circle 2 (teal)
              Positioned(
                left: 10,
                top: 10,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 4),
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        (isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentTeal).withOpacity(0.12),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              // Floating central card
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 10),
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset(0, -value),
                    child: child,
                  );
                },
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: AppTheme.glassDecoration(
                    context: context,
                    opacity: 0.15,
                    borderRadius: 110,
                    borderColor: (isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentIndigo).withOpacity(0.2),
                  ),
                  child: ClipOval(
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.black.withOpacity(0.1)],
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstIn,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              (isDark ? AppTheme.darkAccentIndigo : AppTheme.lightAccentIndigo).withOpacity(0.4),
                              (isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentTeal).withOpacity(0.3),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.code_rounded,
                            size: 80,
                            color: isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentIndigo,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Floating elements (icons)
              _buildFloatingTechIcon(Icons.phone_android, -80, -80, "Flutter", isDark),
              _buildFloatingTechIcon(Icons.web, 80, -70, "React", isDark),
              _buildFloatingTechIcon(Icons.storage, -70, 80, "SQL", isDark),
              _buildFloatingTechIcon(Icons.dns, 85, 75, "Node", isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingTechIcon(IconData icon, double x, double y, String label, bool isDark) {
    return Positioned(
      left: 160 + x - 25,
      top: 160 + y - 25,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 6),
        duration: Duration(seconds: 2 + (x.abs() % 2).toInt()),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, value),
            child: child,
          );
        },
        child: Tooltip(
          message: label,
          child: Container(
            width: 50,
            height: 50,
            decoration: AppTheme.glassDecoration(
              context: context,
              opacity: 0.8,
              borderRadius: 12,
              borderColor: (isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentIndigo).withOpacity(0.3),
            ),
            child: Center(
              child: Icon(
                icon,
                size: 22,
                color: isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentIndigo,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
