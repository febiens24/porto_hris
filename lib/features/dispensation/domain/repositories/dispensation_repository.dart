import 'package:dartz/dartz.dart';

import '../entities/dispensation_detail_entity.dart';
import '../entities/dispensation_entity.dart';

abstract class DispensationRepository {
  Future<Either<Map<String, dynamic>, DispensationEntity>> getDispensationList({
    String? status,
    String? type,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  });

  Future<Either<Map<String, dynamic>, DispensationEntity>>
      getDispensationApprovalList();

  Future<Either<Map<String, dynamic>, DispensationDetailEntity>>
      getDispensationDetail(
    int dispensationId,
  );

  Future<Either<Map<String, dynamic>, DispensationEntity>>
      getDispensationApprovalHistoryList({
    String? status,
    String? type,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  });

  Future<Either<Map<String, dynamic>, DispensationEntity>>
      patchDispensationStatus(
    int dispensationId,
    String state,
    String? cancelReason,
  );

  Future<Either<Map<String, dynamic>, DispensationEntity>>
      approveDispensationRequest(
    int dispensationId,
  );

  Future<Either<Map<String, dynamic>, DispensationEntity>>
      rejectDispensationRequest(
    int dispensationId,
    String rejectReason,
  );
}
