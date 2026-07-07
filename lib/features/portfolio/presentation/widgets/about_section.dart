import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../data/portfolio_data.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final personal = PortfolioData.personalInfo;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Heading
              _buildSectionTitle(context, "About Me"),
              const SizedBox(height: 40),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = constraints.maxWidth > 800;
                  if (isDesktop) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: _buildMetricsGrid(context),
                        ),
                        const SizedBox(width: 60),
                        Expanded(
                          flex: 5,
                          child: _buildBioText(textTheme, personal, isDark),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildBioText(textTheme, personal, isDark),
                        const SizedBox(height: 40),
                        _buildMetricsGrid(context),
                      ],
                    );
                  }
                },
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
            color: (isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentIndigo).withOpacity(0.3),
          ),
        ),
      ],
    );
  }

  Widget _buildBioText(TextTheme textTheme, PersonalInfo personal, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "A brief insight into my professional journey",
          style: textTheme.titleLarge?.copyWith(
            fontSize: 20,
            color: isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentIndigo,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          personal.detailedBio,
          style: textTheme.bodyLarge?.copyWith(
            color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
            fontSize: 16,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentIndigo,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              "Based in ${personal.location}",
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildMetricsGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildMetricCard(context, "3+", "Years of\nExperience")),
            const SizedBox(width: 20),
            Expanded(child: _buildMetricCard(context, "15+", "Completed\nProjects")),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: _buildMetricCard(context, "20+", "Happy\nClients/Users")),
            const SizedBox(width: 20),
            Expanded(child: _buildMetricCard(context, "100%", "Quality & Support")),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(BuildContext context, String value, String label) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.glassDecoration(
        context: context,
        opacity: 0.08,
        borderRadius: 16,
        borderColor: (isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentIndigo).withOpacity(0.1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: textTheme.displayMedium?.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentIndigo,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: isDark ? AppTheme.darkTextPrimary : AppTheme.lightTextPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
