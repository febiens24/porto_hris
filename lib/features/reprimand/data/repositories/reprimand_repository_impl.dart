import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/storage.dart';
import '../../domain/entities/reprimand_detail_entity.dart';
import '../../domain/entities/reprimand_entity.dart';
import '../../domain/repositories/reprimand_repository.dart';
import '../datasources/reprimand_api_services.dart';
import '../models/reprimand_detail_model.dart';
import '../models/reprimand_model.dart';

class ReprimandRepositoryImpl implements ReprimandRepository {
  final ReprimandApiServices reprimandApiServices;
  final SecureStorage secureStorage;

  ReprimandRepositoryImpl(this.reprimandApiServices, this.secureStorage);

  @override
  Future<Either<Map<String, dynamic>, ReprimandEntity>> getReprimandList({
    String? status,
    String? type,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  }) async {
    try {
      final userId = await secureStorage.getUser();
      final result = await reprimandApiServices.fetchReprimandList(
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
        final reprimands = (result["result"] as List<dynamic>?)
            ?.map(
                (e) => ReprimandResultModel.fromJson(e as Map<String, dynamic>))
            .toList();
        final ReprimandModel reprimandList = ReprimandModel(
          status: result["status"],
          message: result["message"],
          result: reprimands,
          types: result["types"],
        );
        return Right(reprimandList);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }

  @override
  Future<Either<Map<String, dynamic>, ReprimandDetailEntity>>
      getReprimandDetail(int overtimeId) async {
    try {
      final userId = await secureStorage.getUser();
      final result =
          await reprimandApiServices.fetchReprimandDetail(userId!, overtimeId);
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final reprimand = ReprimandDetailResultModel.fromJson(result["result"]);

        final ReprimandDetailModel overtimeDetail = ReprimandDetailModel(
          status: result["status"],
          message: result["message"],
          result: reprimand,
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
  Future<Either<Map<String, dynamic>, ReprimandEntity>>
      getReprimandApprovalList() async {
    try {
      final userId = await secureStorage.getUser();
      final result = await reprimandApiServices.fetchReprimandApproval(userId!);
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final reprimandApprovalList = (result["result"] as List<dynamic>?)
            ?.map(
                (e) => ReprimandResultModel.fromJson(e as Map<String, dynamic>))
            .toList();
        final ReprimandModel approvalList = ReprimandModel(
          status: result["status"],
          message: result["message"],
          result: reprimandApprovalList,
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
  Future<Either<Map<String, dynamic>, ReprimandEntity>>
      getReprimandApprovalHistoryList({
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
          await reprimandApiServices.fetchReprimandApprovalHistoryList(
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
        final reprimandApprovalList = (result["result"] as List<dynamic>?)
            ?.map(
                (e) => ReprimandResultModel.fromJson(e as Map<String, dynamic>))
            .toList();
        final ReprimandModel approvalList = ReprimandModel(
          status: result["status"],
          message: result["message"],
          result: reprimandApprovalList,
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
  Future<Either<Map<String, dynamic>, ReprimandEntity>> approveReprimandRequest(
    int reprimandId,
  ) {
    // TODO: implement approveReprimandRequest
    throw UnimplementedError();
  }

  @override
  Future<Either<Map<String, dynamic>, ReprimandEntity>> patchReprimandStatus(
    int reprimandId,
    String state,
    String? cancelReason,
  ) {
    // TODO: implement patchReprimandStatus
    throw UnimplementedError();
  }

  @override
  Future<Either<Map<String, dynamic>, ReprimandEntity>> rejectReprimandRequest(
    int reprimandId,
    String rejectReason,
  ) {
    // TODO: implement rejectReprimandRequest
    throw UnimplementedError();
  }
}
