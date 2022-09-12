import 'package:dartz/dartz.dart';

import '../entities/swap_workdate_entity.dart';
import '../repositories/swap_workdate_repository.dart';

class PatchSwapWorkdateStatusUsecase {
  final SwapWorkdateRepository swapWorkdateRepository;

  PatchSwapWorkdateStatusUsecase(this.swapWorkdateRepository);

  Future<Either<Map<String, dynamic>, SwapWorkdateEntity>> call(
    int swapWorkdateId,
    String state,
    String? cancelReason,
  ) async {
    return await swapWorkdateRepository.patchSwapWorkdateStatus(
        swapWorkdateId, state, cancelReason);
  }
}
