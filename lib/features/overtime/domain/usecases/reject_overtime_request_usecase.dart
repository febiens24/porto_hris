import 'package:dartz/dartz.dart';

import '../entities/overtime_entity.dart';
import '../repositories/overtime_repository.dart';

class RejectOvertimeRequestUsecase {
  final OvertimeRepository overtimeRepository;

  RejectOvertimeRequestUsecase(this.overtimeRepository);

  Future<Either<Map<String, dynamic>, OvertimeEntity>> call(
    int overtimeId,
    String rejectReason,
  ) async {
    return await overtimeRepository.rejectOvertimeRequest(
        overtimeId, rejectReason);
  }
}
