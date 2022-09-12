import 'package:dartz/dartz.dart';

import '../entities/swap_workdate_entity.dart';
import '../repositories/swap_workdate_repository.dart';

class RejectSwapWorkdateRequestUsecase {
  final SwapWorkdateRepository swapWorkdateRepository;

  RejectSwapWorkdateRequestUsecase(this.swapWorkdateRepository);

  Future<Either<Map<String, dynamic>, SwapWorkdateEntity>> call(
    int swapWorkdateId,
    String rejectReason,
  ) async {
    return await swapWorkdateRepository.rejectSwapWorkdateRequest(
        swapWorkdateId, rejectReason);
  }
}
