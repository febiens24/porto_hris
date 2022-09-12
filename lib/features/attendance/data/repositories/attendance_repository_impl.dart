import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/storage.dart';
import '../../domain/entities/attendance_detail_entity.dart';
import '../../domain/entities/attendance_entity.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance_api_services.dart';
import '../models/attendance_detail_model.dart';
import '../models/attendance_model.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceApiServices attendanceApiServices;
  final SecureStorage secureStorage;

  AttendanceRepositoryImpl(this.attendanceApiServices, this.secureStorage);

  @override
  Future<Either<Map<String, dynamic>, AttendanceEntity>>
      getAttendanceList() async {
    try {
      final userId = await secureStorage.getUser();
      final result = await attendanceApiServices.fetchAttendanceList(userId!);
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final attendances = (result["result"] as List<dynamic>?)
            ?.map((e) =>
                AttendanceResultModel.fromJson(e as Map<String, dynamic>))
            .toList();
        final AttendanceModel leaveList = AttendanceModel(
          status: result["status"],
          message: result["message"],
          result: attendances,
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
  Future<Either<Map<String, dynamic>, AttendanceDetailEntity>>
      getAttendanceDetail(int overtimeId) async {
    try {
      final userId = await secureStorage.getUser();
      final result = await attendanceApiServices.fetchAttendanceDetail(
          userId!, overtimeId);
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final attendance =
            AttendanceDetailResultModel.fromJson(result["result"]);

        final AttendanceDetailModel attendanceDetail = AttendanceDetailModel(
          status: result["status"],
          message: result["message"],
          result: attendance,
        );
        return Right(attendanceDetail);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }

  @override
  Future<Either<Map<String, dynamic>, AttendanceEntity>>
      getAttendanceApprovalList() async {
    try {
      final userId = await secureStorage.getUser();
      final result =
          await attendanceApiServices.fetchAttendanceApproval(userId!);
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final attendanceApprovalList = (result["result"] as List<dynamic>?)
            ?.map((e) =>
                AttendanceResultModel.fromJson(e as Map<String, dynamic>))
            .toList();
        final AttendanceModel approvalList = AttendanceModel(
          status: result["status"],
          message: result["message"],
          result: attendanceApprovalList,
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
  Future<Either<Map<String, dynamic>, AttendanceEntity>>
      getAttendanceApprovalHistoryList() async {
    try {
      final userId = await secureStorage.getUser();
      final result =
          await attendanceApiServices.fetchAttendanceApprovalHistory(userId!);
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final attendanceApprovalList = (result["result"] as List<dynamic>?)
            ?.map((e) =>
                AttendanceResultModel.fromJson(e as Map<String, dynamic>))
            .toList();
        final AttendanceModel approvalList = AttendanceModel(
          status: result["status"],
          message: result["message"],
          result: attendanceApprovalList,
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
  Future<Either<Map<String, dynamic>, AttendanceEntity>>
      approveAttendanceRequest(
    int attendanceId,
  ) async {
    try {
      final userId = await secureStorage.getUser();
      final result = await attendanceApiServices.patchAttendanceApprovalStatus(
        userId!,
        attendanceId,
        "approved",
        null,
      );
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final attendanceData = AttendanceModel.fromJson(result);
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
  Future<Either<Map<String, dynamic>, AttendanceEntity>> patchAttendanceStatus(
    int attendanceId,
    String state,
    String? cancelReason,
  ) async {
    try {
      final userId = await secureStorage.getUser();
      final result = await attendanceApiServices.patchAttendanceStatus(
        userId!,
        attendanceId,
        state,
        cancelReason,
      );
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final leaveData = AttendanceModel.fromJson(result);
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
  Future<Either<Map<String, dynamic>, AttendanceEntity>>
      rejectAttendanceRequest(
    int attendanceId,
    String rejectReason,
  ) async {
    try {
      final userId = await secureStorage.getUser();
      final result = await attendanceApiServices.patchAttendanceApprovalStatus(
        userId!,
        attendanceId,
        "reject",
        rejectReason,
      );
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final leaveData = AttendanceModel.fromJson(result);
        return Right(leaveData);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }
}
