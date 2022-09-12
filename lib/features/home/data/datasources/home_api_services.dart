import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../../../../../core/api_const.dart';

part 'home_api_services.g.dart';

@RestApi(baseUrl: apiUrl)
abstract class HomeApiServices {
  factory HomeApiServices(Dio dio, {String baseUrl}) = _HomeApiServices;

  @GET('/api/v1/hris')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchHomepageAPI(
    @Header("User-id") String userid, {
    @Query("get") String? data,
  });
}
