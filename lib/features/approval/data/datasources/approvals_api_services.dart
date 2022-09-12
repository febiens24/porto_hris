import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../../../core/api_const.dart';

part 'approvals_api_services.g.dart';

@RestApi(baseUrl: apiUrl)
abstract class ApprovalsApiServices {
  factory ApprovalsApiServices(Dio dio, {String baseUrl}) =
      _ApprovalsApiServices;

  @GET('/api/v1/hris/approvals')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchApprovalsCount(
    @Header("User-id") String userid,
  );
}
