import 'package:dartz/dartz.dart';

import '../entities/reprimand_entity.dart';
import '../repositories/reprimand_repository.dart';

class PatchReprimandStatusUsecase {
  final ReprimandRepository reprimandRepository;

  PatchReprimandStatusUsecase(this.reprimandRepository);

  Future<Either<Map<String, dynamic>, ReprimandEntity>> call(
    int reprimandId,
    String state,
    String? cancelReason,
  ) async {
    return await reprimandRepository.patchReprimandStatus(
        reprimandId, state, cancelReason);
  }
}
