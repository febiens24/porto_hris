import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/storage.dart';
import '../../domain/entities/swap_workdate_detail_entity.dart';
import '../../domain/entities/swap_workdate_entity.dart';
import '../../domain/repositories/swap_workdate_repository.dart';
import '../datasources/swap_workdate_api_services.dart';
import '../models/swap_workdate_detail_model.dart';
import '../models/swap_workdate_model.dart';

class SwapWorkdateRepositoryImpl implements SwapWorkdateRepository {
  final SwapWorkdateApiServices swapWorkdateApiServices;
  final SecureStorage secureStorage;

  SwapWorkdateRepositoryImpl(this.swapWorkdateApiServices, this.secureStorage);

  @override
  Future<Either<Map<String, dynamic>, SwapWorkdateEntity>> getSwapWorkdateList({
    String? status,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  }) async {
    try {
      final userId = await secureStorage.getUser();
      final result = await swapWorkdateApiServices.fetchSwapWorkdateList(
        userId!,
        status: status,
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
            ?.map((e) =>
                SwapWorkdateResultModel.fromJson(e as Map<String, dynamic>))
            .toList();
        final SwapWorkdateModel leaveList = SwapWorkdateModel(
          status: result["status"],
          message: result["message"],
          result: reprimands,
        );
        return Right(leaveList);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }

  @override
  Future<Either<Map<String, dynamic>, SwapWorkdateDetailEntity>>
      getSwapWorkdateDetail(int overtimeId) async {
    try {
      final userId = await secureStorage.getUser();
      final result = await swapWorkdateApiServices.fetchSwapWorkdateDetail(
          userId!, overtimeId);
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final reprimand =
            SwapWorkdateDetailResultModel.fromJson(result["result"]);

        final SwapWorkdateDetailModel overtimeDetail = SwapWorkdateDetailModel(
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
  Future<Either<Map<String, dynamic>, SwapWorkdateEntity>>
      getSwapWorkdateApprovalList() async {
    try {
      final userId = await secureStorage.getUser();
      final result =
          await swapWorkdateApiServices.fetchSwapWorkdateApproval(userId!);
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final reprimandApprovalList = (result["result"] as List<dynamic>?)
            ?.map((e) =>
                SwapWorkdateResultModel.fromJson(e as Map<String, dynamic>))
            .toList();
        final SwapWorkdateModel approvalList = SwapWorkdateModel(
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
  Future<Either<Map<String, dynamic>, SwapWorkdateEntity>>
      getSwapWorkdateApprovalHistoryList({
    String? status,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  }) async {
    try {
      final userId = await secureStorage.getUser();
      final result =
          await swapWorkdateApiServices.fetchSwapWorkdateApprovalHistoryList(
        userId!,
        status: status,
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
            ?.map((e) =>
                SwapWorkdateResultModel.fromJson(e as Map<String, dynamic>))
            .toList();
        final SwapWorkdateModel approvalList = SwapWorkdateModel(
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
  Future<Either<Map<String, dynamic>, SwapWorkdateEntity>>
      approveSwapWorkdateRequest(
    int swapWorkdateId,
  ) {
    // TODO: implement approveSwapWorkdateRequest
    throw UnimplementedError();
  }

  @override
  Future<Either<Map<String, dynamic>, SwapWorkdateEntity>>
      patchSwapWorkdateStatus(
    int swapWorkdateId,
    String state,
    String? cancelReason,
  ) {
    // TODO: implement patchSwapWorkdateStatus
    throw UnimplementedError();
  }

  @override
  Future<Either<Map<String, dynamic>, SwapWorkdateEntity>>
      rejectSwapWorkdateRequest(
    int swapWorkdateId,
    String rejectReason,
  ) {
    // TODO: implement rejectSwapWorkdateRequest
    throw UnimplementedError();
  }
}
