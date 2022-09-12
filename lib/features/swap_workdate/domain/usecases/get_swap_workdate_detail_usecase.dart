import 'package:dartz/dartz.dart';

import '../entities/swap_workdate_detail_entity.dart';
import '../repositories/swap_workdate_repository.dart';

class GetSwapWorkdateDetailUsecase {
  final SwapWorkdateRepository reprimandRepository;

  GetSwapWorkdateDetailUsecase(this.reprimandRepository);

  Future<Either<Map<String, dynamic>, SwapWorkdateDetailEntity>> call(
    int businessTripId,
  ) async {
    return await reprimandRepository.getSwapWorkdateDetail(businessTripId);
  }
}
