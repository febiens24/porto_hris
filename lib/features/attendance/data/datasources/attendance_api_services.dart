import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../../../../../core/api_const.dart';

part 'attendance_api_services.g.dart';

@RestApi(baseUrl: apiUrl)
abstract class AttendanceApiServices {
  factory AttendanceApiServices(Dio dio, {String baseUrl}) =
      _AttendanceApiServices;

  @GET('/api/v1/hris_attendance')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchAttendanceList(
    @Header("User-id") String userid,
  );

  @GET('/api/v1/hris_attendance/{id}')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchAttendanceDetail(
    @Header("User-id") String userid,
    @Path("id") int attendanceId,
  );

  @GET('/api/v1/hris_attendance/approval')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchAttendanceApproval(
    @Header("User-id") String userid,
  );

  @GET('/api/v1/hris_attendance/approval/history')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchAttendanceApprovalHistory(
    @Header("User-id") String userid,
  );

  @FormUrlEncoded()
  @PATCH('/api/v1/hris_attendance/{id}')
  @Headers(headersHris)
  Future<Map<String, dynamic>> patchAttendanceStatus(
    @Header("User-id") String userid,
    @Path("id") int attendanceId,
    @Field("state") String state,
    @Field("cancelReason") String? cancelReason,
  );

  @FormUrlEncoded()
  @PATCH('/api/v1/hris_attendance/approval/{id}')
  @Headers(headersHris)
  Future<Map<String, dynamic>> patchAttendanceApprovalStatus(
    @Header("User-id") String userid,
    @Path("id") int attendanceId,
    @Field("state") String state,
    @Field("reason") String? rejectReason,
  );
}
