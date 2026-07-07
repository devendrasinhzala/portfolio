import 'package:go_router/go_router.dart';
import '../../features/portfolio/data/portfolio_data.dart';
import '../../features/portfolio/presentation/pages/portfolio_page.dart';
import '../../features/portfolio/presentation/pages/project_detail_page.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Root route maps directly to the single-page scrollable portfolio
    GoRoute(
      path: '/',
      builder: (context, state) => const PortfolioPage(),
    ),
    // Details route maps directly to the full-screen project details view
    GoRoute(
      path: '/project/:slug',
      builder: (context, state) {
        final slug = state.pathParameters['slug']!;
        final project = PortfolioData.projects.firstWhere(
          (p) => p.slug == slug,
          orElse: () => PortfolioData.projects.first,
        );
        return ProjectDetailPage(project: project);
      },
    ),
  ],
);
