import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../core/api_const.dart';

part 'sign_in_datasource.g.dart';

@RestApi(baseUrl: apiUrl)
abstract class SignInApiServices {
  factory SignInApiServices(Dio dio, {String baseUrl}) = _SignInApiServices;

  @FormUrlEncoded()
  @POST('/login')
  @Headers(headersLogin)
  Future<Map<String, dynamic>> staffLogin(
    @Field('username') String username,
    @Field('password') String password,
  );
}
