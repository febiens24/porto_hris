import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../../../../../core/api_const.dart';

part 'overtime_api_services.g.dart';

@RestApi(baseUrl: apiUrl)
abstract class OvertimeApiServices {
  factory OvertimeApiServices(Dio dio, {String baseUrl}) = _OvertimeApiServices;

  @GET('/api/v1/hris_overtime')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchOvertimeList(
    @Header("User-id") String userid, {
    @Query("filter[status]") String? status,
    @Query("filter[type]") String? type,
    @Query("filter[dateFrom]") String? dateFrom,
    @Query("filter[dateTo]") String? dateTo,
    @Query("search[q]") String? q,
    @Query("page") int? page,
  });

  @GET('/api/v1/hris_overtime/{id}')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchOvertimeDetail(
    @Header("User-id") String userid,
    @Path("id") int overtimeId,
  );

  @GET('/api/v1/hris_overtime/approval')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchOvertimeApproval(
    @Header("User-id") String userid,
  );

  @GET('/api/v1/hris_overtime/approval/history')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchOvertimeApprovalHistoryList(
    @Header("User-id") String userid, {
    @Query("filter[status]") String? status,
    @Query("filter[type]") String? type,
    @Query("filter[dateFrom]") String? dateFrom,
    @Query("filter[dateTo]") String? dateTo,
    @Query("search[q]") String? q,
    @Query("page") int? page,
  });

  @FormUrlEncoded()
  @PATCH('/api/v1/hris_overtime/{id}')
  @Headers(headersHris)
  Future<Map<String, dynamic>> patchOvertimeStatus(
    @Header("User-id") String userid,
    @Path("id") int overtimeId,
    @Field("state") String state,
    @Field("cancelReason") String? cancelReason,
  );

  @FormUrlEncoded()
  @PATCH('/api/v1/hris_overtime/approval/{id}')
  @Headers(headersHris)
  Future<Map<String, dynamic>> patchOvertimeApprovalStatus(
    @Header("User-id") String userid,
    @Path("id") int overtimeId,
    @Field("state") String state,
    @Field("reason") String? rejectReason,
  );
}
