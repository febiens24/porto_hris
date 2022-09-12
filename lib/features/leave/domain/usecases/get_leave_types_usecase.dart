import 'package:dartz/dartz.dart';

import '../entities/leave_types_entity.dart';
import '../repositories/leave_repository.dart';

class GetLeaveTypesUsecase {
  final LeaveRepository leaveRepository;

  GetLeaveTypesUsecase(this.leaveRepository);

  Future<Either<Map<String, dynamic>, LeaveTypesEntity>> call() async {
    return await leaveRepository.getLeaveTypes();
  }
}
