import 'package:retrofit_bloc_go_router_getit/core/network/rest_client/rest_client.dart';
import 'package:retrofit_bloc_go_router_getit/model/forms/sign_in_form/sign_in_form.dart';
import 'package:retrofit_bloc_go_router_getit/model/user/user_model.dart';

abstract class AuthRepository{
  Future <UserModel> login(SignInForm form);
}
class AuthRepositoryI extends AuthRepository{
  final RestClient _client;

  AuthRepositoryI({required RestClient client}) : _client = client;

  @override
  Future<UserModel> login(SignInForm form) async {
    return await _client.login(form);
  }

}