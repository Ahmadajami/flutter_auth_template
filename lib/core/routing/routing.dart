
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:retrofit_bloc_go_router_getit/common/locator/locator.dart';
import 'package:retrofit_bloc_go_router_getit/core/routing/scaffold_wrapper.dart';
import 'package:retrofit_bloc_go_router_getit/features/auth/presentation/sign_in/sign_in_screen.dart';
import 'package:retrofit_bloc_go_router_getit/features/home/presentation/home_screen.dart';
import 'package:retrofit_bloc_go_router_getit/features/quotes/quote_screen.dart';
import 'package:retrofit_bloc_go_router_getit/features/setting/screen/theme_change_screen.dart';
import 'package:retrofit_bloc_go_router_getit/features/setting/setting_screen.dart';
import 'package:retrofit_bloc_go_router_getit/features/auth/blocs/auth.dart';


final GlobalKey<NavigatorState> _rootNavigatorKey =
GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _sectionANavigatorKey =
GlobalKey<NavigatorState>();
void setupRoutes(){
  // ignore: no_leading_underscores_for_local_identifiers
  final GoRouter _router = GoRouter(
    restorationScopeId: "routes",
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/auth',
    redirect: (context, state)  {
      final isAuth=context.read<AuthBloc>().state is AuthSuccess;
      final isLoginPage=state.fullPath == "/auth";
      if(isLoginPage)
        {
          return isAuth ? "/":null;
        }
     return isAuth ? null : "/auth";
    },
    routes: [
      GoRoute(path: '/auth',builder: (context, state) => const SignInScreen(),),
      StatefulShellRoute.indexedStack(
        restorationScopeId: "routes_shell",
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            restorationScopeId: "home_routes",
            navigatorKey: _sectionANavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                  path: '/',
                  builder: (BuildContext context, GoRouterState state) =>
                  const HomeScreen(),

              ),
            ],
          ),

          // The route branch for the second tab of the bottom navigation bar.
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/quotes',
                builder: (BuildContext context, GoRouterState state) =>
                const QuoteScreen(),
              ),
            ],
          ),

          // The route branch for the third tab of the bottom navigation bar.
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/setting',
                builder: (BuildContext context, GoRouterState state) =>
                const SettingScreen(),
                routes: [
                  GoRoute(path: '/theme',builder: (context, state) => const ThemeChangeScreen(),)
                ]
              ),
            ],
          ),
        ],
      ),
    ],
  );
  sl.registerSingleton<GoRouter>(_router);


}
