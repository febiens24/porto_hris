import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../../../../../core/api_const.dart';

part 'dispensation_api_services.g.dart';

@RestApi(baseUrl: apiUrl)
abstract class DispensationApiServices {
  factory DispensationApiServices(Dio dio, {String baseUrl}) =
      _DispensationApiServices;

  @GET('/api/v1/hris_dispensation')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchDispensationList(
    @Header("User-id") String userid, {
    @Query("filter[status]") String? status,
    @Query("filter[type]") String? type,
    @Query("filter[dateFrom]") String? dateFrom,
    @Query("filter[dateTo]") String? dateTo,
    @Query("search[q]") String? q,
    @Query("page") int? page,
  });

  @GET('/api/v1/hris_dispensation/approval')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchDispensationApprovalList(
    @Header("User-id") String userid,
  );

  @GET('/api/v1/hris_dispensation/approval/history')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchDispensationApprovalHistoryList(
    @Header("User-id") String userid, {
    @Query("filter[status]") String? status,
    @Query("filter[type]") String? type,
    @Query("filter[dateFrom]") String? dateFrom,
    @Query("filter[dateTo]") String? dateTo,
    @Query("search[q]") String? q,
    @Query("page") int? page,
  });

  @GET('/api/v1/hris_dispensation/{id}')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchDispensationDetail(
    @Header("User-id") String userid,
    @Path("id") int dispensationId,
  );

  @FormUrlEncoded()
  @PATCH('/api/v1/hris_dispensation/{id}')
  @Headers(headersHris)
  Future<Map<String, dynamic>> patchDispensationStatus(
    @Header("User-id") String userid,
    @Path("id") int dispensationId,
    @Field("state") String state,
    @Field("cancelReason") String? cancelReason,
  );

  @FormUrlEncoded()
  @PATCH('/api/v1/hris_dispensation/approval/{id}')
  @Headers(headersHris)
  Future<Map<String, dynamic>> patchDispensationApprovalStatus(
    @Header("User-id") String userid,
    @Path("id") int dispensationId,
    @Field("state") String state,
    @Field("reason") String? rejectReason,
  );
}
