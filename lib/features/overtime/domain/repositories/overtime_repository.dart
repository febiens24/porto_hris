import 'package:dartz/dartz.dart';

import '../entities/overtime_detail_entity.dart';
import '../entities/overtime_entity.dart';

abstract class OvertimeRepository {
  Future<Either<Map<String, dynamic>, OvertimeEntity>> getOvertimeList({
    String? status,
    String? type,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  });

  Future<Either<Map<String, dynamic>, OvertimeDetailEntity>> getOvertimeDetail(
    int overtimeId,
  );

  Future<Either<Map<String, dynamic>, OvertimeEntity>>
      getOvertimeApprovalList();

  Future<Either<Map<String, dynamic>, OvertimeEntity>>
      getOvertimeApprovalHistoryList({
    String? status,
    String? type,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  });

  Future<Either<Map<String, dynamic>, OvertimeEntity>> patchOvertimeStatus(
    int overtimeId,
    String state,
    String? cancelReason,
  );

  Future<Either<Map<String, dynamic>, OvertimeEntity>> approveOvertimeRequest(
    int overtimeId,
  );

  Future<Either<Map<String, dynamic>, OvertimeEntity>> rejectOvertimeRequest(
    int overtimeId,
    String rejectReason,
  );
}
