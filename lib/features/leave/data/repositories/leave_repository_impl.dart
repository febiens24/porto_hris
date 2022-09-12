import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/storage.dart';
import '../../domain/entities/leave_detail_entity.dart';
import '../../domain/entities/leave_entity.dart';
import '../../domain/entities/leave_types_entity.dart';
import '../../domain/repositories/leave_repository.dart';
import '../datasources/leave_api_services.dart';
import '../models/leave_detail_model.dart';
import '../models/leave_model.dart';
import '../models/leave_types_model.dart';

class LeaveRepositoryImpl implements LeaveRepository {
  final LeaveApiServices leaveApiServices;
  final SecureStorage secureStorage;

  LeaveRepositoryImpl(
    this.leaveApiServices,
    this.secureStorage,
  );

  @override
  Future<Either<Map<String, dynamic>, LeaveEntity>> getLeaveList({
    String? status,
    String? type,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  }) async {
    try {
      final userId = await secureStorage.getUser();
      final result = await leaveApiServices.fetchLeaveList(
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
        final leaveData = (result["result"] as List<dynamic>?)
            ?.map((e) => LeaveResultModel.fromJson(e as Map<String, dynamic>))
            .toList();
        final LeaveModel leaveList = LeaveModel(
          status: result["status"],
          message: result["message"],
          result: leaveData,
          types: result["types"],
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
  Future<Either<Map<String, dynamic>, LeaveDetailEntity>> getLeaveDetail(
    int leaveId,
  ) async {
    try {
      final userId = await secureStorage.getUser();
      final result = await leaveApiServices.fetchLeaveDetail(userId!, leaveId);
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final leaveData = LeaveDetailModel.fromJson(result);
        return Right(leaveData);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }

  @override
  Future<Either<Map<String, dynamic>, LeaveTypesEntity>> getLeaveTypes() async {
    try {
      final userId = await secureStorage.getUser();
      final result = await leaveApiServices.fetchLeaveTypes(userId!);
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final leaveTypesData = (result["result"] as List<dynamic>)
            .map((e) =>
                LeaveTypesResultModel.fromJson(e as Map<String, dynamic>))
            .toList();
        final LeaveTypesModel leaveTypes = LeaveTypesModel(
          status: result["status"],
          message: result["message"],
          result: leaveTypesData,
        );
        return Right(leaveTypes);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }

  @override
  Future<Either<Map<String, dynamic>, LeaveEntity>>
      getLeaveApprovalList() async {
    try {
      final userId = await secureStorage.getUser();
      final result = await leaveApiServices.fetchLeaveApprovalList(userId!);
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final leaveApprovalData = (result["result"] as List<dynamic>?)
            ?.map((e) => LeaveResultModel.fromJson(e as Map<String, dynamic>))
            .toList();
        final LeaveModel leaveApprovalList = LeaveModel(
          status: result["status"],
          message: result["message"],
          result: leaveApprovalData,
        );
        return Right(leaveApprovalList);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }

  @override
  Future<Either<Map<String, dynamic>, LeaveEntity>> patchLeaveStatus(
    int leaveId,
    String state,
    String? cancelReason,
  ) async {
    try {
      final userId = await secureStorage.getUser();
      final result = await leaveApiServices.patchLeaveStatus(
        userId!,
        leaveId,
        state,
        cancelReason,
      );
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final leaveData = LeaveModel.fromJson(result);
        return Right(leaveData);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }

  @override
  Future<Either<Map<String, dynamic>, LeaveEntity>> approveLeaveRequest(
    int leaveId,
  ) async {
    try {
      final userId = await secureStorage.getUser();
      final result = await leaveApiServices.patchLeaveApprovalStatus(
        userId!,
        leaveId,
        "approved",
        null,
      );
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final leaveData = LeaveModel.fromJson(result);
        return Right(leaveData);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }

  @override
  Future<Either<Map<String, dynamic>, LeaveEntity>> rejectLeaveRequest(
    int leaveId,
    String rejectReason,
  ) async {
    try {
      final userId = await secureStorage.getUser();
      final result = await leaveApiServices.patchLeaveApprovalStatus(
        userId!,
        leaveId,
        "reject",
        rejectReason,
      );
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final leaveData = LeaveModel.fromJson(result);
        return Right(leaveData);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }

  @override
  Future<Either<Map<String, dynamic>, LeaveEntity>>
      getLeaveApprovalHistoryList({
    String? status,
    String? type,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  }) async {
    try {
      final userId = await secureStorage.getUser();
      final result = await leaveApiServices.fetchLeaveApprovalHistoryList(
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
        final leaveApprovalData = (result["result"] as List<dynamic>?)
            ?.map((e) => LeaveResultModel.fromJson(e as Map<String, dynamic>))
            .toList();

        final LeaveModel leaveApprovalList = LeaveModel(
          status: result["status"],
          message: result["message"],
          result: leaveApprovalData,
          types: result["types"],
        );

        return Right(leaveApprovalList);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }
}
