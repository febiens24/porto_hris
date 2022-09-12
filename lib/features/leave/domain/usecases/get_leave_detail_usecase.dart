import 'package:dartz/dartz.dart';

import '../entities/leave_detail_entity.dart';
import '../repositories/leave_repository.dart';

class GetLeaveDetailUsecase {
  final LeaveRepository leaveRepository;

  GetLeaveDetailUsecase(this.leaveRepository);

  Future<Either<Map<String, dynamic>, LeaveDetailEntity>> call(
    int leaveId,
  ) async {
    return await leaveRepository.getLeaveDetail(leaveId);
  }
}
