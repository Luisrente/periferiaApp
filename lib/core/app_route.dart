import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:periferiamovies/dependencies_injection.dart';
import 'package:periferiamovies/features/auth/presentation/blog/login/auth_bloc.dart';
import 'package:periferiamovies/features/auth/presentation/screen/login/login_page.dart';
import 'package:periferiamovies/features/features.dart';
import 'package:periferiamovies/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

enum Routes {
  root("/"),
  splashScreen("/splashscreen"),

  /// Home Page
  dashboard("/dashboard"),
  settings("/settings"),

  // Auth Page
  login("/auth/login"),
  register("/auth/register"),
  ;

  const Routes(this.path);

  final String path;
}

class AppRoute {
  static late BuildContext context;

  AppRoute.setStream(BuildContext ctx) {
    context = ctx;
  }

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: Routes.splashScreen.path,
        name: Routes.splashScreen.name,
        builder: (_, __) => SplashScreenPage(),
      ),
       GoRoute(
          path: Routes.login.path,
          name: Routes.login.name,
          builder: (_, __) => const LoginPage(),
       ),
      GoRoute(
        path: Routes.root.path,
        name: Routes.root.name,
        redirect: (_, __) => Routes.dashboard.path,
      ),

      ShellRoute(
        builder: (_, __, child) => BlocProvider(
          create: (context) => sl<MainBlog>(),
          child: MainPage(child: child),
        ),
        routes: [
          GoRoute(
            path: Routes.dashboard.path,
            name: Routes.dashboard.name,
            builder: (_, __) => const DashboardPage(),
          ),
          GoRoute(
            path: Routes.settings.path,
            name: Routes.settings.name,
            builder: (_, __) => const SettingsScreen(),
          ),
        ],
      ),
    ],
    initialLocation: Routes.splashScreen.path,
    routerNeglect: true,
    debugLogDiagnostics: kDebugMode,
    refreshListenable: GoRouterRefreshStream(context.read<AuthBlog>().stream),
    redirect: (_, GoRouterState state) {
      final bool isLoginPage = state.matchedLocation == Routes.login.path ||
          state.matchedLocation == Routes.register.path;

      ///  Check if not login
      ///  if current page is login page we don't need to direct user
      ///  but if not we must direct user to login page
      if (!((MainBoxMixin.mainBox?.get(MainBoxKeys.isLogin.name) as bool?) ??
          false)) {
        return isLoginPage ? null : Routes.login.path;
      }

      // /// Check if already login and in login page
      // /// we should direct user to main page

      if (isLoginPage &&
          ((MainBoxMixin.mainBox?.get(MainBoxKeys.isLogin.name) as bool?) ??
              false)) {
        return Routes.root.path;
      }

      /// No direct
      return null;
    },
  );
}
