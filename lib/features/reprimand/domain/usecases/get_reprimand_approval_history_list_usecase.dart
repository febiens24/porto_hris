import 'package:dartz/dartz.dart';

import '../entities/reprimand_entity.dart';
import '../repositories/reprimand_repository.dart';

class GetReprimandApprovalHistoryListUsecase {
  final ReprimandRepository reprimandRepository;

  GetReprimandApprovalHistoryListUsecase(this.reprimandRepository);

  Future<Either<Map<String, dynamic>, ReprimandEntity>> call({
    String? status,
    String? type,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  }) async {
    return await reprimandRepository.getReprimandApprovalHistoryList(
      status: status,
      type: type,
      dateFrom: dateFrom,
      dateTo: dateTo,
      q: q,
      page: page,
    );
  }
}
