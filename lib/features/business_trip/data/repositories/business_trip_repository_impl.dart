import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/storage.dart';
import '../../domain/entities/business_trip_detail_entity.dart';
import '../../domain/entities/business_trip_entity.dart';
import '../../domain/repositories/business_trip_repository.dart';
import '../datasources/business_trip_api_services.dart';
import '../models/business_trip_detail_model.dart';
import '../models/business_trip_model.dart';

class BusinessTripRepositoryImpl implements BusinessTripRepository {
  final BusinessTripApiServices businessTripApiServices;
  final SecureStorage secureStorage;

  BusinessTripRepositoryImpl(
    this.businessTripApiServices,
    this.secureStorage,
  );

  @override
  Future<Either<Map<String, dynamic>, BusinessTripEntity>> getBusinessTripList({
    String? status,
    String? type,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  }) async {
    try {
      final userId = await secureStorage.getUser();
      final result = await businessTripApiServices.fetchBusinessTripList(
        userId!,
        status: status,
        type: type,
        dateFrom: dateFrom,
        dateTo: dateTo,
        q: q,
        page: page,
      );
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final businessTripData = (result["result"] as List<dynamic>?)
            ?.map((e) =>
                BusinessTripResultModel.fromJson(e as Map<String, dynamic>))
            .toList();

        final BusinessTripModel businessTripList = BusinessTripModel(
          status: result["status"],
          message: result["message"],
          result: businessTripData,
          types: result["types"],
        );

        return Right(businessTripList);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.toString(),
      });
    }
  }

  @override
  Future<Either<Map<String, dynamic>, BusinessTripDetailEntity>>
      getBusinessTripDetail(int businessTripId) async {
    try {
      final userId = await secureStorage.getUser();
      final result = await businessTripApiServices.fetchBusinessTripDetail(
        userId!,
        businessTripId,
      );
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final leaveData = BusinessTripDetailModel.fromJson(result);
        return Right(leaveData);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.toString(),
      });
    }
  }

  @override
  Future<Either<Map<String, dynamic>, BusinessTripEntity>>
      getBusinessTripApprovalList() async {
    try {
      final userId = await secureStorage.getUser();
      final result =
          await businessTripApiServices.fetchBusinessTripApprovalList(userId!);
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final businessTripData = (result["result"] as List<dynamic>?)
            ?.map((e) =>
                BusinessTripResultModel.fromJson(e as Map<String, dynamic>))
            .toList();
        final BusinessTripModel businessTripList = BusinessTripModel(
          status: result["status"],
          message: result["message"],
          result: businessTripData,
        );
        return Right(businessTripList);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.type,
      });
    } on SocketException catch (e) {
      return Left({
        "status": "Error",
        "result": e.message,
      });
    }
  }

  @override
  Future<Either<Map<String, dynamic>, BusinessTripEntity>>
      getBusinessTripApprovalHistoryList({
    String? status,
    String? type,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  }) async {
    try {
      final userId = await secureStorage.getUser();
      final result =
          await businessTripApiServices.fetchBusinessTripApprovalHistoryList(
        userId!,
        status: status,
        type: type,
        dateFrom: dateFrom,
        dateTo: dateTo,
        q: q,
        page: page,
      );
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final businessTripData = (result["result"] as List<dynamic>?)
            ?.map((e) =>
                BusinessTripResultModel.fromJson(e as Map<String, dynamic>))
            .toList();
        final BusinessTripModel businessTripList = BusinessTripModel(
          status: result["status"],
          message: result["message"],
          result: businessTripData,
          types: result["types"],
        );
        return Right(businessTripList);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.type,
      });
    } on SocketException catch (e) {
      return Left({
        "status": "Error",
        "result": e.message,
      });
    }
  }

  @override
  Future<Either<Map<String, dynamic>, BusinessTripEntity>>
      approveBusinessTripRequest(
    int businessTripId,
  ) async {
    try {
      final userId = await secureStorage.getUser();
      final result =
          await businessTripApiServices.patchBusinessTripApprovalStatus(
        userId!,
        businessTripId,
        "approved",
        null,
      );
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final attendanceData = BusinessTripModel.fromJson(result);
        return Right(attendanceData);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }

  @override
  Future<Either<Map<String, dynamic>, BusinessTripEntity>>
      patchBusinessTripStatus(
    int businessTripId,
    String state,
    String? cancelReason,
  ) async {
    try {
      final userId = await secureStorage.getUser();
      final result = await businessTripApiServices.patchBusinessTripStatus(
        userId!,
        businessTripId,
        state,
        cancelReason,
      );
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final businessTripData = BusinessTripModel.fromJson(result);
        return Right(businessTripData);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }

  @override
  Future<Either<Map<String, dynamic>, BusinessTripEntity>>
      rejectBusinessTripRequest(
    int businessTripId,
    String rejectReason,
  ) async {
    try {
      final userId = await secureStorage.getUser();
      final result =
          await businessTripApiServices.patchBusinessTripApprovalStatus(
        userId!,
        businessTripId,
        "reject",
        rejectReason,
      );
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final businessTripData = BusinessTripModel.fromJson(result);
        return Right(businessTripData);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }
}
