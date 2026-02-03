import 'package:go_router/go_router.dart';
import 'package:to_do/screens/create_screen.dart';
import 'package:to_do/screens/home_screen.dart';
import 'package:to_do/screens/setting_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/home',
    routes: <RouteBase>[
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/create',
        builder: (context, state) => const CreateScreen(),
      ),
    ],
  );
}
