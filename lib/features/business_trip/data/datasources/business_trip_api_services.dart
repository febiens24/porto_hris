import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../../../../../core/api_const.dart';

part 'business_trip_api_services.g.dart';

@RestApi(baseUrl: apiUrl)
abstract class BusinessTripApiServices {
  factory BusinessTripApiServices(Dio dio, {String baseUrl}) =
      _BusinessTripApiServices;

  @GET('/api/v1/hris_business_trip')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchBusinessTripList(
    @Header("User-id") String userid, {
    @Query("filter[status]") String? status,
    @Query("filter[type]") String? type,
    @Query("filter[dateFrom]") String? dateFrom,
    @Query("filter[dateTo]") String? dateTo,
    @Query("search[q]") String? q,
    @Query("page") int? page,
  });

  @GET('/api/v1/hris_business_trip/{id}')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchBusinessTripDetail(
    @Header("User-id") String userid,
    @Path("id") int businessTripId,
  );

  @GET('/api/v1/hris_business_trip/approval')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchBusinessTripApprovalList(
    @Header("User-id") String userid,
  );

  @GET('/api/v1/hris_business_trip/approval/history')
  @Headers(headersHris)
  Future<Map<String, dynamic>> fetchBusinessTripApprovalHistoryList(
    @Header("User-id") String userid, {
    @Query("filter[status]") String? status,
    @Query("filter[type]") String? type,
    @Query("filter[dateFrom]") String? dateFrom,
    @Query("filter[dateTo]") String? dateTo,
    @Query("search[q]") String? q,
    @Query("page") int? page,
  });

  @FormUrlEncoded()
  @PATCH('/api/v1/hris_business_trip/{id}')
  @Headers(headersHris)
  Future<Map<String, dynamic>> patchBusinessTripStatus(
    @Header("User-id") String userid,
    @Path("id") int businessTripId,
    @Field("state") String state,
    @Field("cancelReason") String? cancelReason,
  );

  @FormUrlEncoded()
  @PATCH('/api/v1/hris_business_trip/approval/{id}')
  @Headers(headersHris)
  Future<Map<String, dynamic>> patchBusinessTripApprovalStatus(
    @Header("User-id") String userid,
    @Path("id") int businessTripId,
    @Field("state") String state,
    @Field("reason") String? rejectReason,
  );
}
