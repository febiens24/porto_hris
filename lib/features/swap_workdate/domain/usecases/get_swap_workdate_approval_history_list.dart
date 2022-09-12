import 'package:dartz/dartz.dart';

import '../entities/swap_workdate_entity.dart';
import '../repositories/swap_workdate_repository.dart';

class GetSwapWorkdateApprovalHistoryListUsecase {
  final SwapWorkdateRepository swapWorkdateRepository;

  GetSwapWorkdateApprovalHistoryListUsecase(this.swapWorkdateRepository);

  Future<Either<Map<String, dynamic>, SwapWorkdateEntity>> call({
    String? status,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  }) async {
    return await swapWorkdateRepository.getSwapWorkdateApprovalHistoryList(
      status: status,
      dateFrom: dateFrom,
      dateTo: dateTo,
      q: q,
      page: page,
    );
  }
}
