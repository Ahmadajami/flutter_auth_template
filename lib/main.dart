

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:retrofit_bloc_go_router_getit/common/locator/locator.dart';
import 'package:retrofit_bloc_go_router_getit/core/app_theme/app_theme_cubit.dart';
import 'package:retrofit_bloc_go_router_getit/core/routing/routing.dart';
import 'package:retrofit_bloc_go_router_getit/features/auth/blocs/auth.dart';
import 'package:retrofit_bloc_go_router_getit/features/quotes/bloc/quote_bloc.dart';
import 'package:retrofit_bloc_go_router_getit/init.dart';

Future<void> main() async {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await init();
  setupRoutes();
  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<QuoteBloc>(create: (_) => sl.get<QuoteBloc>()),
          BlocProvider<AuthBloc>(create: (_) => sl.get<AuthBloc>()..add(AuthStorageRequested()),),
          BlocProvider<AppThemeCubit>(create: (_) =>sl.get<AppThemeCubit>() ,)
        ],
        child: const MyApp(),

      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc,AuthState>(
      listenWhen: (previous, current) {
        return previous!=current;
      },

      listener: (context, state) {
        if (state is AuthLoading) {
          // While loading, you might want to keep the splash screen or show a loading indicator
          return;
        }
        // "Cant Use Go Router "refreshListenable" Will Be Deprecated
        //More Info go to "https://github.com/flutter/flutter/issues/116651"
        sl.get<GoRouter>().refresh();
        FlutterNativeSplash.remove();
      },
      child: MaterialApp.router(
        themeMode: context.watch<AppThemeCubit>().state,
        debugShowCheckedModeBanner: false,
        restorationScopeId: "root",
        title: 'Bloc_retrofit',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal, brightness: Brightness.light),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal, brightness: Brightness.dark),
          useMaterial3: true,
        ) ,
        routerConfig: sl.get<GoRouter>(),
      ),
    );
  }
}
