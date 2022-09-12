import 'package:dartz/dartz.dart';

import '../entities/overtime_entity.dart';
import '../repositories/overtime_repository.dart';

class ApproveOvertimeRequestUsecase {
  final OvertimeRepository overtimeRepository;

  ApproveOvertimeRequestUsecase(this.overtimeRepository);

  Future<Either<Map<String, dynamic>, OvertimeEntity>> call(
    int overtimeId,
  ) async {
    return await overtimeRepository.approveOvertimeRequest(overtimeId);
  }
}
