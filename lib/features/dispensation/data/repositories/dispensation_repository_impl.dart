import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/storage.dart';
import '../../domain/entities/dispensation_detail_entity.dart';
import '../../domain/entities/dispensation_entity.dart';
import '../../domain/repositories/dispensation_repository.dart';
import '../datasource/dispensation_api_services.dart';
import '../models/dispensation_detail_model.dart';
import '../models/dispensation_model.dart';

class DispensationRepositoryImpl implements DispensationRepository {
  final DispensationApiServices dispensationApiServices;
  final SecureStorage secureStorage;

  DispensationRepositoryImpl(
    this.dispensationApiServices,
    this.secureStorage,
  );

  @override
  Future<Either<Map<String, dynamic>, DispensationEntity>> getDispensationList({
    String? status,
    String? type,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  }) async {
    try {
      final userId = await secureStorage.getUser();
      final result = await dispensationApiServices.fetchDispensationList(
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
        final dispensationData = (result["result"] as List<dynamic>)
            .map((e) =>
                DispensationResultModel.fromJson(e as Map<String, dynamic>))
            .toList();

        final DispensationModel dispensationList = DispensationModel(
          status: result["status"],
          message: result["message"],
          result: dispensationData,
          types: result["types"],
        );

        return Right(dispensationList);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }

  @override
  Future<Either<Map<String, dynamic>, DispensationDetailEntity>>
      getDispensationDetail(int dispensationId) async {
    try {
      final userId = await secureStorage.getUser();
      final result = await dispensationApiServices.fetchDispensationDetail(
        userId!,
        dispensationId,
      );
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final dispensationData =
            DispensationDetailResultModel.fromJson(result["result"]);

        final DispensationDetailModel dispensationDetail =
            DispensationDetailModel(
          status: result["status"],
          message: result["message"],
          result: dispensationData,
        );

        return Right(dispensationDetail);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }

  @override
  Future<Either<Map<String, dynamic>, DispensationEntity>>
      getDispensationApprovalList() async {
    try {
      final userId = await secureStorage.getUser();
      final result =
          await dispensationApiServices.fetchDispensationApprovalList(userId!);
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final dispensationApprovalData = (result["result"] as List<dynamic>)
            .map((e) =>
                DispensationResultModel.fromJson(e as Map<String, dynamic>))
            .toList();

        final DispensationModel dispensationApprovalList = DispensationModel(
          status: result["status"],
          message: result["message"],
          result: dispensationApprovalData,
        );

        return Right(dispensationApprovalList);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }

  @override
  Future<Either<Map<String, dynamic>, DispensationEntity>>
      getDispensationApprovalHistoryList({
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
          await dispensationApiServices.fetchDispensationApprovalHistoryList(
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
        final dispensationApprovalData = (result["result"] as List<dynamic>)
            .map((e) =>
                DispensationResultModel.fromJson(e as Map<String, dynamic>))
            .toList();

        final DispensationModel dispensationApprovalList = DispensationModel(
          status: result["status"],
          message: result["message"],
          result: dispensationApprovalData,
          types: result["types"],
        );

        return Right(dispensationApprovalList);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }

  @override
  Future<Either<Map<String, dynamic>, DispensationEntity>>
      approveDispensationRequest(
    int dispensationId,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Map<String, dynamic>, DispensationEntity>>
      patchDispensationStatus(
    int dispensationId,
    String state,
    String? cancelReason,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Map<String, dynamic>, DispensationEntity>>
      rejectDispensationRequest(
    int dispensationId,
    String rejectReason,
  ) async {
    try {
      final userId = await secureStorage.getUser();
      final result =
          await dispensationApiServices.patchDispensationApprovalStatus(
        userId!,
        dispensationId,
        "reject",
        rejectReason,
      );
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final dispensationData = DispensationModel.fromJson(result);
        return Right(dispensationData);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }
}
