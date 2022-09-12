import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../../../../../core/api_const.dart';

part 'swap_workdate_api_services.g.dart';

@RestApi(baseUrl: apiUrl)
abstract class SwapWorkdateApiServices {
  factory SwapWorkdateApiServices(Dio dio, {String baseUrl}) =
      _SwapWorkdateApiServices;

  @GET('/api/v1/hris_swap_workdate')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchSwapWorkdateList(
    @Header("User-id") String userid, {
    @Query("filter[status]") String? status,
    @Query("filter[dateFrom]") String? dateFrom,
    @Query("filter[dateTo]") String? dateTo,
    @Query("search[q]") String? q,
    @Query("page") int? page,
  });

  @GET('/api/v1/hris_swap_workdate/{id}')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchSwapWorkdateDetail(
    @Header("User-id") String userid,
    @Path("id") int swapworkdateId,
  );

  @GET('/api/v1/hris_swap_workdate/approval')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchSwapWorkdateApproval(
    @Header("User-id") String userid,
  );

  @GET('/api/v1/hris_swap_workdate/approval/history')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchSwapWorkdateApprovalHistoryList(
    @Header("User-id") String userid, {
    @Query("filter[status]") String? status,
    @Query("filter[dateFrom]") String? dateFrom,
    @Query("filter[dateTo]") String? dateTo,
    @Query("search[q]") String? q,
    @Query("page") int? page,
  });

  @FormUrlEncoded()
  @PATCH('/api/v1/hris_swap_workdate/{id}')
  @Headers(headersHris)
  Future<Map<String, dynamic>> patchSwapWorkdateStatus(
    @Header("User-id") String userid,
    @Path("id") int swapWorkdateId,
    @Field("state") String state,
    @Field("cancelReason") String? cancelReason,
  );

  @FormUrlEncoded()
  @PATCH('/api/v1/hris_swap_workdate/approval/{id}')
  @Headers(headersHris)
  Future<Map<String, dynamic>> patchSwapWorkdateApprovalStatus(
    @Header("User-id") String userid,
    @Path("id") int swapWorkdateId,
    @Field("state") String state,
    @Field("reason") String? rejectReason,
  );
}
