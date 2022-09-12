import 'package:dartz/dartz.dart';

import '../entities/overtime_entity.dart';
import '../repositories/overtime_repository.dart';

class PatchOvertimeStatusUsecase {
  final OvertimeRepository overtimeRepository;

  PatchOvertimeStatusUsecase(this.overtimeRepository);

  Future<Either<Map<String, dynamic>, OvertimeEntity>> call(
    int overtimeId,
    String state,
    String? cancelReason,
  ) async {
    return await overtimeRepository.patchOvertimeStatus(
        overtimeId, state, cancelReason);
  }
}
