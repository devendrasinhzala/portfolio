import 'package:flutter/material.dart';

class PersonalInfo {
  final String name;
  final String title;
  final String bio;
  final String detailedBio;
  final String location;
  final String email;
  final String github;
  final String linkedin;
  final String twitter;

  const PersonalInfo({
    required this.name,
    required this.title,
    required this.bio,
    required this.detailedBio,
    required this.location,
    required this.email,
    required this.github,
    required this.linkedin,
    required this.twitter,
  });
}

class Skill {
  final String name;
  final String category;
  final double level; // 0.0 to 1.0
  final IconData icon;

  const Skill({
    required this.name,
    required this.category,
    required this.level,
    required this.icon,
  });
}

class Project {
  final String slug;
  final String title;
  final String description;
  final String detailedDescription;
  final List<String> features;
  final List<String> screenshots;
  final List<String> technologies;
  final String githubUrl;
  final String demoUrl;
  final List<Color> gradientColors;

  const Project({
    required this.slug,
    required this.title,
    required this.description,
    required this.detailedDescription,
    required this.features,
    required this.screenshots,
    required this.technologies,
    required this.githubUrl,
    required this.demoUrl,
    required this.gradientColors,
  });
}

class Experience {
  final String role;
  final String company;
  final String duration;
  final List<String> achievements;
  final String companyUrl;

  const Experience({
    required this.role,
    required this.company,
    required this.duration,
    required this.achievements,
    required this.companyUrl,
  });
}

class PortfolioData {
  static const PersonalInfo personalInfo = PersonalInfo(
    name: "Devendrasinh Zala",
    title: "Full-Stack Mobile & Web Developer",
    bio: "I build highly aesthetic, scalable, and user-centric applications.",
    detailedBio: "I am a passionate software engineer specializing in building high-fidelity cross-platform applications. With expertise in Flutter, React, and server-side engineering, I bridge the gap between design and functionality. I focus on clean architecture, performance optimization, and elegant UI/UX design.",
    location: "Gujarat, India",
    email: "devendrasinhzala@example.com",
    github: "https://github.com/devendrasinhzala",
    linkedin: "https://linkedin.com/in/devendrasinhzala",
    twitter: "https://twitter.com/devendrasinhzala",
  );

  static const List<Skill> skills = [
    // Mobile Development
    Skill(name: "Flutter", category: "Mobile Development", level: 0.95, icon: Icons.phone_android),
    Skill(name: "Dart", category: "Mobile Development", level: 0.95, icon: Icons.code),
    Skill(name: "Riverpod / Bloc", category: "Mobile Development", level: 0.90, icon: Icons.layers),
    Skill(name: "Android (Kotlin)", category: "Mobile Development", level: 0.75, icon: Icons.android),
    Skill(name: "iOS (Swift)", category: "Mobile Development", level: 0.70, icon: Icons.phone_iphone),

    // Web & Backend
    Skill(name: "React.js", category: "Web & Backend", level: 0.85, icon: Icons.web),
    Skill(name: "Node.js / Express", category: "Web & Backend", level: 0.80, icon: Icons.dns),
    Skill(name: "Go (Golang)", category: "Web & Backend", level: 0.70, icon: Icons.terminal),
    Skill(name: "REST APIs / WebSockets", category: "Web & Backend", level: 0.90, icon: Icons.swap_calls),

    // Databases & Cloud
    Skill(name: "PostgreSQL", category: "Databases & Cloud", level: 0.85, icon: Icons.storage),
    Skill(name: "MongoDB / Firebase", category: "Databases & Cloud", level: 0.88, icon: Icons.cloud_queue),
    Skill(name: "Docker", category: "Databases & Cloud", level: 0.75, icon: Icons.directions_boat),
    Skill(name: "AWS / GCP", category: "Databases & Cloud", level: 0.70, icon: Icons.cloud),

    // Tools & Methodologies
    Skill(name: "Git & Version Control", category: "Tools & Design", level: 0.90, icon: Icons.commit),
    Skill(name: "CI/CD (GitHub Actions)", category: "Tools & Design", level: 0.80, icon: Icons.loop),
    Skill(name: "UI/UX & Figma", category: "Tools & Design", level: 0.85, icon: Icons.palette),
  ];

  static const List<Project> projects = [
    Project(
      slug: "zenith-commerce",
      title: "Zenith Commerce",
      description: "A gorgeous, dark-themed e-commerce experience showcasing customized fluid layouts, advanced local cart management via Hive, responsive product filters, and stripe payment simulations.",
      detailedDescription: "Zenith Commerce is a premier cross-platform e-commerce solution designed for maximum visual impact and fluid navigation. Built using Flutter and Dart, the application implements high-fidelity transitions, custom-drawn elements, and a unified state architecture driven by Riverpod. It features lightning-fast local cache queries utilizing Hive, a responsive sidebar configuration system for search/filters, and mock payment gateways simulating Stripe validation flows.",
      features: [
        "High-fidelity theme transitions and layout dynamics",
        "Responsive grid system optimized for mobile and desktop viewports",
        "Local caching of product listings using Hive",
        "State-driven shopping cart management via Riverpod",
        "Stripe payment validation simulator with transaction receipts"
      ],
      screenshots: ["screen_mock_1", "screen_mock_2", "screen_mock_3"],
      technologies: ["Flutter", "Dart", "Riverpod", "Hive", "Stripe API"],
      githubUrl: "https://github.com/devendrasinhzala/zenith-commerce",
      demoUrl: "https://zenith-commerce-demo.web.app",
      gradientColors: [Color(0xff6366F1), Color(0xff4F46E5)],
    ),
    Project(
      slug: "devdoc-engine",
      title: "DevDoc Engine",
      description: "A developer documentation client that formats Markdown directories into responsive documentation websites. Supports full-text search, code blocks with syntax highlighting, and bookmarking.",
      detailedDescription: "DevDoc Engine is a static site parser and client interface designed specifically for software engineers. It transforms folders containing Markdown documentation files into fully interactive, responsive documentation portals. It runs a custom index search builder for instant lookup queries, formats code snippets using highlight modules, and offers local browser bookmarking features.",
      features: [
        "Markdown folder structural parsing into navigation trees",
        "Instant client-side full-text index search",
        "Beautiful syntax highlighting with Fira Code support",
        "User bookmarks saved to local storage for offline retrieval",
        "Highly optimized, SEO-friendly layout styling"
      ],
      screenshots: ["screen_mock_1", "screen_mock_2", "screen_mock_3"],
      technologies: ["React", "TypeScript", "Markdown-IT", "TailwindCSS"],
      githubUrl: "https://github.com/devendrasinhzala/devdoc-engine",
      demoUrl: "https://devdoc-engine.web.app",
      gradientColors: [Color(0xff0D9488), Color(0xff14B8A6)],
    ),
    Project(
      slug: "aerotrack-dashboard",
      title: "AeroTrack Dashboard",
      description: "A real-time flight tracker map interface that aggregates data from ADS-B WebSockets. Runs local background isolate calculations to render smooth plane path paths on custom map canvasses.",
      detailedDescription: "AeroTrack is an advanced map interface mapping real-time flight metrics aggregated from public WebSockets feeds. To prevent stuttering during high-frequency data updates, AeroTrack runs local isolate computations on secondary threads to calculate flight vector interpolations, drawing clean coordinates on custom Canvas painters.",
      features: [
        "High-frequency WebSocket data ingestion from flight feeds",
        "Multi-threaded Dart Isolate computations for coordinate interpolation",
        "Highly customized paint coordinates and paths drawn via CustomPainter",
        "Fluid panning and zoom maps featuring tile preloading",
        "Interactive details panels showing flight trajectory data"
      ],
      screenshots: ["screen_mock_1", "screen_mock_2", "screen_mock_3"],
      technologies: ["Flutter", "WebSockets", "CustomPainter", "Dart Isolates"],
      githubUrl: "https://github.com/devendrasinhzala/aerotrack-dashboard",
      demoUrl: "https://aerotrack-dashboard.web.app",
      gradientColors: [Color(0xffF59E0B), Color(0xffD97706)],
    ),
    Project(
      slug: "taskflow-kanban",
      title: "TaskFlow Kanban",
      description: "An elegant project management canvas. Includes interactive drag-and-drop lists, task urgency tags, automatic offline synchronization, and calendar heatmaps.",
      detailedDescription: "TaskFlow Kanban is a robust task and project management client built for high productivity. It features smooth drag-and-drop mechanics across workflow columns, priority markers, automatic background offline sync with local SQLite databases, and calendar heatmaps visualising tasks completed over time.",
      features: [
        "Interactive drag-and-drop columns and board cards",
        "Offline-first database synchronization using SQLite",
        "Calendar productivity heatmaps tracking work milestones",
        "Local notification dispatch system for task deadlines",
        "Project-specific color categories and customizable tags"
      ],
      screenshots: ["screen_mock_1", "screen_mock_2", "screen_mock_3"],
      technologies: ["Flutter Web", "Riverpod", "SQLite", "LocalNotifications"],
      githubUrl: "https://github.com/devendrasinhzala/taskflow-kanban",
      demoUrl: "https://taskflow-kanban.web.app",
      gradientColors: [Color(0xffEC4899), Color(0xffD946EF)],
    ),
  ];

  static const List<Experience> experiences = [
    Experience(
      role: "Senior Flutter Engineer",
      company: "TechInnovations Labs",
      duration: "2024 - Present",
      companyUrl: "https://techinnovations.com",
      achievements: [
        "Led the migration of a legacy native application into a unified Flutter codebase, reducing time-to-market for new features by 50%.",
        "Optimized Dart rendering cycles and implemented lazy loading lists, improving scroll performance from 42 FPS to 60 FPS.",
        "Introduced CI/CD integration using GitHub Actions, automating builds and reducing developer delivery times by 3 hours per week.",
      ],
    ),
    Experience(
      role: "Full-Stack Developer",
      company: "DevLabs Studio",
      duration: "2022 - 2024",
      companyUrl: "https://devlabs.io",
      achievements: [
        "Built and deployed 5 custom applications for Android and iOS using Flutter, Riverpod, and REST API architectures.",
        "Designed and maintained scalable backends using Node.js, Express, and PostgreSQL databases.",
        "Collaborated closely with visual designers to implement pixel-perfect micro-animations and responsive components.",
      ],
    ),
  ];
}
