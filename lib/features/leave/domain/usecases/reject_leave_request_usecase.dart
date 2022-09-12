import 'package:dartz/dartz.dart';

import '../entities/leave_entity.dart';
import '../repositories/leave_repository.dart';

class RejectLeaveRequestUsecase {
  final LeaveRepository leaveRepository;

  RejectLeaveRequestUsecase(this.leaveRepository);

  Future<Either<Map<String, dynamic>, LeaveEntity>> call(
    int leaveId,
    String rejectReason,
  ) async {
    return await leaveRepository.rejectLeaveRequest(leaveId, rejectReason);
  }
}
