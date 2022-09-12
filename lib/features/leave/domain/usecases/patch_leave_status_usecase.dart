import 'package:dartz/dartz.dart';

import '../entities/leave_entity.dart';
import '../repositories/leave_repository.dart';

class PatchLeaveStatusUsecase {
  final LeaveRepository leaveRepository;

  PatchLeaveStatusUsecase(this.leaveRepository);

  Future<Either<Map<String, dynamic>, LeaveEntity>> call(
    int leaveId,
    String state,
    String? cancelReason,
  ) async {
    return await leaveRepository.patchLeaveStatus(leaveId, state, cancelReason);
  }
}
