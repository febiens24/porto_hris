import 'package:dartz/dartz.dart';

import '../entities/reprimand_entity.dart';
import '../repositories/reprimand_repository.dart';

class RejectReprimandRequestUsecase {
  final ReprimandRepository reprimandRepository;

  RejectReprimandRequestUsecase(this.reprimandRepository);

  Future<Either<Map<String, dynamic>, ReprimandEntity>> call(
    int reprimandId,
    String rejectReason,
  ) async {
    return await reprimandRepository.rejectReprimandRequest(
        reprimandId, rejectReason);
  }
}
