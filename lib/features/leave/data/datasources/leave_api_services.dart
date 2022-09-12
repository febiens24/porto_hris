import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../../../../../core/api_const.dart';

part 'leave_api_services.g.dart';

@RestApi(baseUrl: apiUrl)
abstract class LeaveApiServices {
  factory LeaveApiServices(Dio dio, {String baseUrl}) = _LeaveApiServices;

  @GET('/api/v1/hris_leave')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchLeaveList(
    @Header("User-id") String userid, {
    @Query("filter[status]") String? status,
    @Query("filter[type]") String? type,
    @Query("filter[dateFrom]") String? dateFrom,
    @Query("filter[dateTo]") String? dateTo,
    @Query("search[q]") String? q,
    @Query("page") int? page,
  });

  @GET('/api/v1/hris_leave/{id}')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchLeaveDetail(
    @Header("User-id") String userid,
    @Path("id") int leaveId,
  );

  @FormUrlEncoded()
  @PATCH('/api/v1/hris_leave/{id}')
  @Headers(headersHris)
  Future<Map<String, dynamic>> patchLeaveStatus(
    @Header("User-id") String userid,
    @Path("id") int leaveId,
    @Field("state") String state,
    @Field("cancelReason") String? cancelReason,
  );

  @FormUrlEncoded()
  @PATCH('/api/v1/hris_leave/approval/{id}')
  @Headers(headersHris)
  Future<Map<String, dynamic>> patchLeaveApprovalStatus(
    @Header("User-id") String userid,
    @Path("id") int leaveId,
    @Field("state") String state,
    @Field("reason") String? rejectReason,
  );

  @GET('/api/v1/hris_leave/types')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchLeaveTypes(
    @Header("User-id") String userid,
  );

  @GET('/api/v1/hris_leave/approval')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchLeaveApprovalList(
    @Header("User-id") String userid,
  );

  @GET('/api/v1/hris_leave/approval/history')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchLeaveApprovalHistoryList(
    @Header("User-id") String userid, {
    @Query("filter[status]") String? status,
    @Query("filter[type]") String? type,
    @Query("filter[dateFrom]") String? dateFrom,
    @Query("filter[dateTo]") String? dateTo,
    @Query("search[q]") String? q,
    @Query("page") int? page,
  });
}
