import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/theme.dart';
import '../../data/portfolio_data.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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
              _buildSectionTitle(context, "Featured Projects"),
              const SizedBox(height: 40),
              
              // Projects Grid using Wrap
              LayoutBuilder(
                builder: (context, constraints) {
                  // Calculate dynamic width and height matching previous grid ratio
                  final double spacing = 24.0;
                  final double itemWidth;
                  if (constraints.maxWidth > 900) {
                    itemWidth = (constraints.maxWidth - (spacing * 2)) / 3;
                  } else if (constraints.maxWidth > 600) {
                    itemWidth = (constraints.maxWidth - spacing) / 2;
                  } else {
                    itemWidth = constraints.maxWidth;
                  }

                  // 0.82 aspect ratio: height = width / 0.82
                  final double itemHeight = itemWidth / 0.82;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: PortfolioData.projects.map((project) {
                      return SizedBox(
                        width: itemWidth,
                        height: itemHeight,
                        child: ProjectCard(project: project),
                      );
                    }).toList(),
                  );
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
            color: (isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentIndigo).withAlpha(77),
          ),
        ),
      ],
    );
  }
}

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    final accentColor = isDark ? AppTheme.darkAccentTeal : AppTheme.lightAccentIndigo;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          context.push('/project/${widget.project.slug}');
        },
        child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        transform: _isHovered ? Matrix4.translationValues(0.0, -10.0, 0.0) : Matrix4.identity(),
        decoration: AppTheme.glassDecoration(
          context: context,
          opacity: _isHovered ? 0.12 : 0.06,
          borderRadius: 16,
          borderColor: _isHovered ? accentColor.withAlpha(102) : accentColor.withAlpha(26),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Project Top Card Accent Header (with project gradient colors)
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                gradient: LinearGradient(
                  colors: widget.project.gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -20,
                    bottom: -20,
                    child: Icon(
                      Icons.code,
                      size: 140,
                      color: Colors.white.withAlpha(26),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 20,
                    child: Text(
                      widget.project.title[0],
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Project Body
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.project.title,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Text(
                        widget.project.description,
                        style: textTheme.bodyMedium?.copyWith(
                          height: 1.5,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Technologies Tags Wrap
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.project.technologies.take(3).map((tech) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: accentColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: accentColor.withAlpha(38),
                            ),
                          ),
                          child: Text(
                            tech,
                            style: textTheme.labelSmall?.copyWith(
                              color: accentColor,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    
                    // Action Links
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.github, size: 20),
                          tooltip: "GitHub Repository",
                          onPressed: () => _launchUrl(widget.project.githubUrl),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.open_in_new, size: 20),
                          tooltip: "Live Demo",
                          onPressed: () => _launchUrl(widget.project.demoUrl),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
