import 'package:dartz/dartz.dart';

import '../entities/reprimand_detail_entity.dart';
import '../entities/reprimand_entity.dart';

abstract class ReprimandRepository {
  Future<Either<Map<String, dynamic>, ReprimandEntity>> getReprimandList({
    String? status,
    String? type,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  });

  Future<Either<Map<String, dynamic>, ReprimandDetailEntity>>
      getReprimandDetail(
    int reprimandId,
  );

  Future<Either<Map<String, dynamic>, ReprimandEntity>>
      getReprimandApprovalList();

  Future<Either<Map<String, dynamic>, ReprimandEntity>>
      getReprimandApprovalHistoryList({
    String? status,
    String? type,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  });

  Future<Either<Map<String, dynamic>, ReprimandEntity>> patchReprimandStatus(
    int reprimandId,
    String state,
    String? cancelReason,
  );

  Future<Either<Map<String, dynamic>, ReprimandEntity>> approveReprimandRequest(
    int reprimandId,
  );

  Future<Either<Map<String, dynamic>, ReprimandEntity>> rejectReprimandRequest(
    int reprimandId,
    String rejectReason,
  );
}
