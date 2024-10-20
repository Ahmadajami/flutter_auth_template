import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofit_bloc_go_router_getit/model/forms/sign_in_form/sign_in_form.dart';
import 'package:retrofit_bloc_go_router_getit/model/quote/quote_model.dart';
import 'package:retrofit_bloc_go_router_getit/model/user/user_model.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://dummyjson.com')
abstract class RestClient {
  factory RestClient (Dio dio)= _RestClient;
  @POST('/auth/login')
  Future<UserModel> login( @Body() SignInForm form );
  @GET("/auth/quote/{id}")
  Future<QuoteModel> getQuote (@Path() String id);

}