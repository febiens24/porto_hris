import 'package:dartz/dartz.dart';

import '../entities/leave_entity.dart';
import '../repositories/leave_repository.dart';

class GetLeaveApprovalListUsecase {
  final LeaveRepository leaveRepository;

  GetLeaveApprovalListUsecase(this.leaveRepository);

  Future<Either<Map<String, dynamic>, LeaveEntity>> call() async {
    return await leaveRepository.getLeaveApprovalList();
  }
}
