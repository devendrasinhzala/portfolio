import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/theme.dart';
import '../../data/portfolio_data.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Title
              _buildSectionTitle(context, "Work Experience"),
              const SizedBox(height: 40),
              
              // Timeline List using Column & Map
              Column(
                children: List.generate(PortfolioData.experiences.length, (index) {
                  final exp = PortfolioData.experiences[index];
                  final isLast = index == PortfolioData.experiences.length - 1;
                  
                  return IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Timeline line and bullet
                        _buildTimelineIndicator(context, isLast),
                        
                        // Content Card
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 24.0, bottom: 32.0),
                            child: ExperienceCard(experience: exp),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Text(
          title,
          style: textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 1,
            color: (isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentIndigo).withAlpha(77),
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineIndicator(BuildContext context, bool isLast) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentIndigo;

    return SizedBox(
      width: 40,
      child: Column(
        children: [
          // Timeline Bullet Dot
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkBg : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: accentColor,
                width: 3.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: accentColor.withAlpha(77),
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ],
            ),
          ),
          // Connecting Line
          if (!isLast)
            Expanded(
              child: Container(
                width: 3.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      accentColor,
                      accentColor.withAlpha(13),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ExperienceCard extends StatefulWidget {
  final Experience experience;

  const ExperienceCard({super.key, required this.experience});

  @override
  State<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard> {
  bool _isHovered = false;

  Future<void> _launchCompany(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    final accentColor = isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentIndigo;
    final isWide = MediaQuery.of(context).size.width > 600;

    final roleWidget = Text(
      widget.experience.role,
      style: textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );

    final companyWidget = InkWell(
      onTap: () => _launchCompany(widget.experience.companyUrl),
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Text(
          "@ ${widget.experience.company}",
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: accentColor,
            fontSize: 16,
          ),
        ),
      ),
    );

    final durationWidget = Text(
      widget.experience.duration,
      style: textTheme.labelSmall?.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(24),
        decoration: AppTheme.glassDecoration(
          context: context,
          opacity: _isHovered ? 0.10 : 0.05,
          borderRadius: 16,
          borderColor: _isHovered ? accentColor.withAlpha(77) : accentColor.withAlpha(26),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Role & Company Header
            if (isWide)
              Row(
                children: [
                  Expanded(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      children: [
                        roleWidget,
                        companyWidget,
                      ],
                    ),
                  ),
                  durationWidget,
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  roleWidget,
                  const SizedBox(height: 4),
                  companyWidget,
                  const SizedBox(height: 8),
                  durationWidget,
                ],
              ),
            
            const SizedBox(height: 20),
            
            // Achievements List
            Column(
              children: widget.experience.achievements.map((bullet) {
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
                          bullet,
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
            ),
          ],
        ),
      ),
    );
  }
}
