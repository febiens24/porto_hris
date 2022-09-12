import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../../../../../core/api_const.dart';

part 'reprimand_api_services.g.dart';

@RestApi(baseUrl: apiUrl)
abstract class ReprimandApiServices {
  factory ReprimandApiServices(Dio dio, {String baseUrl}) =
      _ReprimandApiServices;

  @GET('/api/v1/hris_reprimand')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchReprimandList(
    @Header("User-id") String userid, {
    @Query("filter[status]") String? status,
    @Query("filter[type]") String? type,
    @Query("filter[dateFrom]") String? dateFrom,
    @Query("filter[dateTo]") String? dateTo,
    @Query("search[q]") String? q,
    @Query("page") int? page,
  });

  @GET('/api/v1/hris_reprimand/{id}')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchReprimandDetail(
    @Header("User-id") String userid,
    @Path("id") int reprimandId,
  );

  @GET('/api/v1/hris_reprimand/approval')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchReprimandApproval(
    @Header("User-id") String userid,
  );

  @GET('/api/v1/hris_reprimand/approval/history')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchReprimandApprovalHistoryList(
    @Header("User-id") String userid, {
    @Query("filter[status]") String? status,
    @Query("filter[type]") String? type,
    @Query("filter[dateFrom]") String? dateFrom,
    @Query("filter[dateTo]") String? dateTo,
    @Query("search[q]") String? q,
    @Query("page") int? page,
  });

  @FormUrlEncoded()
  @PATCH('/api/v1/hris_reprimand/{id}')
  @Headers(headersHris)
  Future<Map<String, dynamic>> patchReprimandStatus(
    @Header("User-id") String userid,
    @Path("id") int reprimandId,
    @Field("state") String state,
    @Field("cancelReason") String? cancelReason,
  );

  @FormUrlEncoded()
  @PATCH('/api/v1/hris_reprimand/approval/{id}')
  @Headers(headersHris)
  Future<Map<String, dynamic>> patchReprimandApprovalStatus(
    @Header("User-id") String userid,
    @Path("id") int reprimandId,
    @Field("state") String state,
    @Field("reason") String? rejectReason,
  );
}
