import 'package:dartz/dartz.dart';

import '../entities/reprimand_entity.dart';
import '../repositories/reprimand_repository.dart';

class ApproveReprimandRequestUsecase {
  final ReprimandRepository reprimandRepository;

  ApproveReprimandRequestUsecase(this.reprimandRepository);

  Future<Either<Map<String, dynamic>, ReprimandEntity>> call(
    int reprimandId,
  ) async {
    return await reprimandRepository.approveReprimandRequest(reprimandId);
  }
}
