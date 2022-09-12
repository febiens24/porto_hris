import 'package:dartz/dartz.dart';

import '../entities/dispensation_entity.dart';
import '../repositories/dispensation_repository.dart';

class PatchDispensationStatusUsecase {
  final DispensationRepository dispensationRepository;

  PatchDispensationStatusUsecase(this.dispensationRepository);

  Future<Either<Map<String, dynamic>, DispensationEntity>> call(
    int dispensationId,
    String state,
    String? cancelReason,
  ) async {
    return await dispensationRepository.patchDispensationStatus(
        dispensationId, state, cancelReason);
  }
}
