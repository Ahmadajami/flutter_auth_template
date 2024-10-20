import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:retrofit_bloc_go_router_getit/common/constants/storage_constants.dart';
import 'package:retrofit_bloc_go_router_getit/core/storage/storage_service.dart';
import 'package:retrofit_bloc_go_router_getit/features/auth/repository/auth_repository.dart';
import 'package:retrofit_bloc_go_router_getit/model/forms/sign_in_form/sign_in_form.dart';
import 'package:retrofit_bloc_go_router_getit/model/user/user_model.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final StorageService _storageService;

  AuthBloc({required AuthRepository authRepository,required StorageService storageService}) :  _storageService=storageService,_authRepository=authRepository ,super(AuthInitial()) {
    on<AuthLoginRequested>(_login);
    on<AuthStorageRequested>(_storageCheck);
    on<AuthLogoutRequested>((event, emit) async{

      await storageService.deleteData(StorageConstants.userDataKey);
      return  emit(AuthInitial());
    },);
  }
  Future<void> _login(AuthLoginRequested event,Emitter<AuthState> emit )
  async{
    emit(AuthLoading());
    final SignInForm form =event.form;
    try{
      final UserModel userModel=await _authRepository.login(form);
      final jsonString =jsonEncode(userModel);
      await _storageService.saveData(StorageConstants.userDataKey,jsonString);
      return emit(AuthSuccess(userModel: userModel));
    } on DioException catch (error){

      return  emit(AuthFailure('Got error : ${error.response!.statusCode} -> ${error.response!.statusMessage}'));
    }


  }
  Future<void> _storageCheck(AuthStorageRequested event,Emitter<AuthState> emit)
  async {
    emit(AuthLoading());
    final userModelJSON=  await _storageService.readData(StorageConstants.userDataKey);
    if(userModelJSON == null)
    {
      return emit(AuthInitial());
    }

    final UserModel userModel= UserModel.fromJson(jsonDecode(userModelJSON));

    return emit(AuthSuccess(userModel: userModel));

  }
}
