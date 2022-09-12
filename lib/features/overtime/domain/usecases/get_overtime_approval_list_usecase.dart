import 'package:dartz/dartz.dart';

import '../entities/overtime_entity.dart';
import '../repositories/overtime_repository.dart';

class GetOvertimeApprovalListUsecase {
  final OvertimeRepository overtimeRepository;

  GetOvertimeApprovalListUsecase(this.overtimeRepository);

  Future<Either<Map<String, dynamic>, OvertimeEntity>> call() async {
    return await overtimeRepository.getOvertimeApprovalList();
  }
}
