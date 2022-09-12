import 'package:dartz/dartz.dart';

import '../entities/leave_detail_entity.dart';
import '../entities/leave_entity.dart';
import '../entities/leave_types_entity.dart';

abstract class LeaveRepository {
  Future<Either<Map<String, dynamic>, LeaveEntity>> getLeaveList({
    String? status,
    String? type,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  });

  Future<Either<Map<String, dynamic>, LeaveDetailEntity>> getLeaveDetail(
    int leaveId,
  );

  Future<Either<Map<String, dynamic>, LeaveTypesEntity>> getLeaveTypes();

  Future<Either<Map<String, dynamic>, LeaveEntity>> getLeaveApprovalList();

  Future<Either<Map<String, dynamic>, LeaveEntity>> patchLeaveStatus(
    int leaveId,
    String state,
    String? cancelReason,
  );

  Future<Either<Map<String, dynamic>, LeaveEntity>> approveLeaveRequest(
    int leaveId,
  );

  Future<Either<Map<String, dynamic>, LeaveEntity>> rejectLeaveRequest(
    int leaveId,
    String rejectReason,
  );

  Future<Either<Map<String, dynamic>, LeaveEntity>>
      getLeaveApprovalHistoryList({
    String? status,
    String? type,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  });
}
