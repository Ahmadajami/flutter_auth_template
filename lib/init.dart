import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:retrofit_bloc_go_router_getit/common/locator/locator.dart';
import 'package:retrofit_bloc_go_router_getit/core/app_theme/app_theme_cubit.dart';
import 'package:retrofit_bloc_go_router_getit/core/network/dio/init_dio.dart';
import 'package:retrofit_bloc_go_router_getit/core/network/rest_client/rest_client.dart';
import 'package:retrofit_bloc_go_router_getit/core/storage/storage_service.dart';
import 'package:retrofit_bloc_go_router_getit/features/auth/blocs/auth.dart';
import 'package:retrofit_bloc_go_router_getit/features/auth/repository/auth_repository.dart';
import 'package:retrofit_bloc_go_router_getit/features/quotes/bloc/quote_bloc.dart';
import 'package:retrofit_bloc_go_router_getit/features/quotes/repository/quote_repository.dart';

import 'core/network/dio/interceptors/token.dart';


/*
I was presented with two approaches for handling token management in the TokenInterceptor:
1.Using StorageService directly for token retrieval, which decouples token access from state management.
2. Using AuthBloc to manage token access reactively based on authentication state.
I chose the ``[[first]]`` approach to simplify the interceptor by decoupling it from AuthBloc,
keeping the token management logic separate.
However, token refresh logic will still be handled in the AuthBloc to maintain control over authentication flows and state management.
 */

Future<void> init() async {
  try {
    // -- Registering Storage Service
    sl.registerSingleton<StorageService>(StorageService());

// -- Registering Dio for Network Calls
    sl.registerSingleton<Dio>(buildDio());

// -- Registering RestClient Factory
    sl.registerFactory<RestClient>(() => RestClient(sl.get<Dio>()));

// -- Registering Quote Repository and Bloc
    sl.registerFactory<QuoteRepository>(() => QuoteRepositoryI(client: sl.get<RestClient>()));
    sl.registerFactory<QuoteBloc>(() => QuoteBloc(quoteRepository: sl.get<QuoteRepository>()));

// -- Registering Auth Repository and Bloc
    sl.registerFactory<AuthRepository>(() => AuthRepositoryI(client: sl.get<RestClient>()));
    sl.registerFactory<AuthBloc>(() => AuthBloc(
      authRepository: sl.get<AuthRepository>(),
      storageService: sl.get<StorageService>(),
    ));

// -- Registering Theme Cubit
    sl.registerFactory<AppThemeCubit>(() => AppThemeCubit());

// Adding Dio Token Interceptors AFTER all registrations
    sl.get<Dio>().interceptors.add(TokenInterceptor( storageService: sl.get<StorageService>(),));
  } catch (e) {
    // Handle or log the exception
    log('Error during dependency registration: $e');
  }
}
