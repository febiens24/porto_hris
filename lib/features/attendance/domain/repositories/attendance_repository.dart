import 'package:dartz/dartz.dart';

import '../entities/attendance_detail_entity.dart';
import '../entities/attendance_entity.dart';

abstract class AttendanceRepository {
  Future<Either<Map<String, dynamic>, AttendanceEntity>> getAttendanceList();

  Future<Either<Map<String, dynamic>, AttendanceDetailEntity>>
      getAttendanceDetail(
    int attendanceId,
  );

  Future<Either<Map<String, dynamic>, AttendanceEntity>>
      getAttendanceApprovalList();

  Future<Either<Map<String, dynamic>, AttendanceEntity>>
      getAttendanceApprovalHistoryList();

  Future<Either<Map<String, dynamic>, AttendanceEntity>> patchAttendanceStatus(
    int attendanceId,
    String state,
    String? cancelReason,
  );

  Future<Either<Map<String, dynamic>, AttendanceEntity>>
      approveAttendanceRequest(
    int attendanceId,
  );

  Future<Either<Map<String, dynamic>, AttendanceEntity>>
      rejectAttendanceRequest(
    int attendanceId,
    String rejectReason,
  );
}
