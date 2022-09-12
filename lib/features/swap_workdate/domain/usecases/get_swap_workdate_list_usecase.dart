import 'package:dartz/dartz.dart';

import '../entities/swap_workdate_entity.dart';
import '../repositories/swap_workdate_repository.dart';

class GetSwapWorkdateListUsecase {
  final SwapWorkdateRepository reprimandRepository;

  GetSwapWorkdateListUsecase(this.reprimandRepository);

  Future<Either<Map<String, dynamic>, SwapWorkdateEntity>> call({
    String? status,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  }) async {
    return await reprimandRepository.getSwapWorkdateList(
      status: status,
      dateFrom: dateFrom,
      dateTo: dateTo,
      q: q,
      page: page,
    );
  }
}
