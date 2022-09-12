import 'package:dartz/dartz.dart';

import '../entities/leave_entity.dart';
import '../repositories/leave_repository.dart';

class ApproveLeaveRequestUsecase {
  final LeaveRepository leaveRepository;

  ApproveLeaveRequestUsecase(this.leaveRepository);

  Future<Either<Map<String, dynamic>, LeaveEntity>> call(
    int leaveId,
  ) async {
    return await leaveRepository.approveLeaveRequest(leaveId);
  }
}
