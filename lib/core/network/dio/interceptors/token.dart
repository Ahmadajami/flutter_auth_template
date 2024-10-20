import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:retrofit_bloc_go_router_getit/common/constants/storage_constants.dart';
import 'package:retrofit_bloc_go_router_getit/core/storage/storage_service.dart';
import 'package:retrofit_bloc_go_router_getit/model/user/user_model.dart';

class TokenInterceptor extends Interceptor {
  final StorageService _storageService;

  TokenInterceptor({required StorageService storageService}):_storageService=storageService;

  final protectedRoutes = [
    "auth/quote",
  ];


  final unprotectedRoutes = [
    '/auth/login',
  ];

  bool _isUnprotectedRoute(String path) {
    return unprotectedRoutes.any((route) => path.contains(route));
  }


  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (_isUnprotectedRoute(options.path)) {
      // Bypass adding the token for unprotected requests
      return handler.next(options);
    }
    final userModelJSON=  await _storageService.readData(StorageConstants.userDataKey);
    if(userModelJSON == null)
    {
      return handler.next(options);
    }

    final String token= UserModel.fromJson(jsonDecode(userModelJSON)).accessToken;

        options.headers['Authorization'] = 'Bearer $token';
    // Continue with the request
    return handler.next(options);
  }

}