import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../data/portfolio_data.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;

    // Dynamically group skills by category
    final groupedSkills = <String, List<Skill>>{};
    for (var skill in PortfolioData.skills) {
      groupedSkills.putIfAbsent(skill.category, () => []).add(skill);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Title
              _buildSectionTitle(context, "Skills & Technologies"),
              const SizedBox(height: 40),
              
              // Group Content using Column and Wrap
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: groupedSkills.keys.map((category) {
                  final skills = groupedSkills[category]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
                        child: Text(
                          category,
                          style: textTheme.titleLarge?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentIndigo,
                          ),
                        ),
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          // Calculate item width based on available constraints
                          final itemWidth = constraints.maxWidth > 900 
                              ? (constraints.maxWidth - 48) / 4 
                              : (constraints.maxWidth > 600 
                                  ? (constraints.maxWidth - 32) / 3 
                                  : (constraints.maxWidth - 16) / 2);

                          return Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            children: skills.map((skill) {
                              return SizedBox(
                                width: itemWidth,
                                child: _buildSkillCard(context, skill),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  );
                }).toList(),
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

  Widget _buildSkillCard(BuildContext context, Skill skill) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    final accentColor = isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentIndigo;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: AppTheme.glassDecoration(
        context: context,
        opacity: 0.08,
        borderRadius: 12,
        borderColor: accentColor.withAlpha(26),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accentColor.withAlpha(26),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  skill.icon,
                  size: 20,
                  color: accentColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  skill.name,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                "${(skill.level * 100).toInt()}%",
                style: textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: skill.level,
              backgroundColor: isDark ? Colors.white.withAlpha(20) : Colors.black.withAlpha(13),
              valueColor: AlwaysStoppedAnimation<Color>(accentColor),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
