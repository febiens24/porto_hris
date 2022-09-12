import 'package:dartz/dartz.dart';

import '../entities/swap_workdate_detail_entity.dart';
import '../entities/swap_workdate_entity.dart';

abstract class SwapWorkdateRepository {
  Future<Either<Map<String, dynamic>, SwapWorkdateEntity>> getSwapWorkdateList({
    String? status,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  });

  Future<Either<Map<String, dynamic>, SwapWorkdateDetailEntity>>
      getSwapWorkdateDetail(
    int reprimandId,
  );

  Future<Either<Map<String, dynamic>, SwapWorkdateEntity>>
      getSwapWorkdateApprovalList();

  Future<Either<Map<String, dynamic>, SwapWorkdateEntity>>
      getSwapWorkdateApprovalHistoryList({
    String? status,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  });

  Future<Either<Map<String, dynamic>, SwapWorkdateEntity>>
      patchSwapWorkdateStatus(
    int swapWorkdateId,
    String state,
    String? cancelReason,
  );

  Future<Either<Map<String, dynamic>, SwapWorkdateEntity>>
      approveSwapWorkdateRequest(
    int swapWorkdateId,
  );

  Future<Either<Map<String, dynamic>, SwapWorkdateEntity>>
      rejectSwapWorkdateRequest(
    int swapWorkdateId,
    String rejectReason,
  );
}
