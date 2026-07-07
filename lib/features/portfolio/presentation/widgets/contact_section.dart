import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/theme.dart';
import '../../data/portfolio_data.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _isHoveredButton = false;

  Future<void> _launchEmail() async {
    final personal = PortfolioData.personalInfo;
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: personal.email,
      queryParameters: {
        'subject': 'Collaboration Opportunity',
      },
    );
    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final personal = PortfolioData.personalInfo;
    final accentColor = isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentIndigo;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Tiny Label
              Text(
                "04. What's Next?",
                style: textTheme.labelLarge?.copyWith(
                  color: accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              // Big Title
              Text(
                "Get In Touch",
                style: textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
              ),
              const SizedBox(height: 24),
              
              // Description
              Text(
                "I am currently open to new opportunities, freelance contracts, and interesting collaborations. If you have a project idea, a question, or simply want to connect, feel free to drop a message! I will get back to you as soon as possible.",
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge?.copyWith(
                  color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 48),
              
              // Contact Card Container
              Container(
                padding: const EdgeInsets.all(24),
                decoration: AppTheme.glassDecoration(
                  context: context,
                  opacity: 0.05,
                  borderRadius: 16,
                  borderColor: accentColor.withAlpha(26),
                ),
                child: Column(
                  children: [
                    // Email row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.email_outlined, color: accentColor),
                        const SizedBox(width: 12),
                        SelectableText(
                          personal.email,
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Location row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.map_outlined, color: accentColor),
                        const SizedBox(width: 12),
                        Text(
                          personal.location,
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              
              // CTA Button
              MouseRegion(
                onEnter: (_) => setState(() => _isHoveredButton = true),
                onExit: (_) => setState(() => _isHoveredButton = false),
                child: AnimatedScale(
                  scale: _isHoveredButton ? 1.05 : 1.0,
                  duration: const Duration(milliseconds: 150),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: _isHoveredButton && isDark
                          ? [
                              BoxShadow(
                                color: accentColor.withAlpha(77),
                                blurRadius: 15,
                                offset: const Offset(0, 4),
                              )
                            ]
                          : null,
                    ),
                    child: ElevatedButton(
                      onPressed: _launchEmail,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 22),
                        backgroundColor: accentColor,
                        foregroundColor: isDark ? AppTheme.darkBg : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.mail_outline_rounded, size: 20),
                          SizedBox(width: 10),
                          Text(
                            "Say Hello!",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 80),
              
              // Footer signature
              Divider(color: (isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary).withAlpha(26)),
              const SizedBox(height: 24),
              Text(
                "Designed & Built by Devendrasinh Zala",
                style: textTheme.labelSmall?.copyWith(
                  color: (isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary).withAlpha(153),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "© 2026 • Flutter Web Application",
                style: textTheme.labelSmall?.copyWith(
                  color: (isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary).withAlpha(102),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
