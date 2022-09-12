import 'package:dartz/dartz.dart';

import '../entities/swap_workdate_entity.dart';
import '../repositories/swap_workdate_repository.dart';

class ApproveSwapWorkdateRequestUsecase {
  final SwapWorkdateRepository swapWorkdateRepository;

  ApproveSwapWorkdateRequestUsecase(this.swapWorkdateRepository);

  Future<Either<Map<String, dynamic>, SwapWorkdateEntity>> call(
    int swapWorkdateId,
  ) async {
    return await swapWorkdateRepository
        .approveSwapWorkdateRequest(swapWorkdateId);
  }
}
