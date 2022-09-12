import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/storage.dart';
import '../../domain/entities/overtime_detail_entity.dart';
import '../../domain/entities/overtime_entity.dart';
import '../../domain/repositories/overtime_repository.dart';
import '../datasources/overtime_api_services.dart';
import '../models/overtime_detail_model.dart';
import '../models/overtime_model.dart';

class OvertimeRepositoryImpl implements OvertimeRepository {
  final OvertimeApiServices overtimeApiServices;
  final SecureStorage secureStorage;

  OvertimeRepositoryImpl(this.overtimeApiServices, this.secureStorage);

  @override
  Future<Either<Map<String, dynamic>, OvertimeEntity>> getOvertimeList({
    String? status,
    String? type,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  }) async {
    try {
      final userId = await secureStorage.getUser();
      final result = await overtimeApiServices.fetchOvertimeList(
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
        final overtimes = (result["result"] as List<dynamic>?)
            ?.map(
                (e) => OvertimeResultModel.fromJson(e as Map<String, dynamic>))
            .toList();
        final OvertimeModel overtimeList = OvertimeModel(
          status: result["status"],
          message: result["message"],
          result: overtimes,
          types: result["types"],
        );
        return Right(overtimeList);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }

  @override
  Future<Either<Map<String, dynamic>, OvertimeDetailEntity>> getOvertimeDetail(
      int overtimeId) async {
    try {
      final userId = await secureStorage.getUser();
      final result =
          await overtimeApiServices.fetchOvertimeDetail(userId!, overtimeId);
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final overtime = OvertimeDetailResultModel.fromJson(result["result"]);

        final OvertimeDetailModel overtimeDetail = OvertimeDetailModel(
          status: result["status"],
          message: result["message"],
          result: overtime,
        );
        return Right(overtimeDetail);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }

  @override
  Future<Either<Map<String, dynamic>, OvertimeEntity>>
      getOvertimeApprovalList() async {
    try {
      final userId = await secureStorage.getUser();
      final result = await overtimeApiServices.fetchOvertimeApproval(userId!);
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final overtimeApprovalList = (result["result"] as List<dynamic>?)
            ?.map(
                (e) => OvertimeResultModel.fromJson(e as Map<String, dynamic>))
            .toList();
        final OvertimeModel approvalList = OvertimeModel(
          status: result["status"],
          message: result["message"],
          result: overtimeApprovalList,
        );
        return Right(approvalList);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }

  @override
  Future<Either<Map<String, dynamic>, OvertimeEntity>>
      getOvertimeApprovalHistoryList({
    String? status,
    String? type,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  }) async {
    try {
      final userId = await secureStorage.getUser();
      final result = await overtimeApiServices.fetchOvertimeApprovalHistoryList(
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
        final overtimeApprovalList = (result["result"] as List<dynamic>?)
            ?.map(
                (e) => OvertimeResultModel.fromJson(e as Map<String, dynamic>))
            .toList();
        final OvertimeModel approvalList = OvertimeModel(
          status: result["status"],
          message: result["message"],
          result: overtimeApprovalList,
          types: result["types"],
        );
        return Right(approvalList);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }

  @override
  Future<Either<Map<String, dynamic>, OvertimeEntity>> approveOvertimeRequest(
    int overtimeId,
  ) {
    // TODO: implement approveOvertimeRequest
    throw UnimplementedError();
  }

  @override
  Future<Either<Map<String, dynamic>, OvertimeEntity>> patchOvertimeStatus(
    int overtimeId,
    String state,
    String? cancelReason,
  ) {
    // TODO: implement patchOvertimeStatus
    throw UnimplementedError();
  }

  @override
  Future<Either<Map<String, dynamic>, OvertimeEntity>> rejectOvertimeRequest(
    int overtimeId,
    String rejectReason,
  ) {
    // TODO: implement rejectOvertimeRequest
    throw UnimplementedError();
  }
}
