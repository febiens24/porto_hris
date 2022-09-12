import 'package:dartz/dartz.dart';

import '../entities/dispensation_entity.dart';
import '../repositories/dispensation_repository.dart';

class RejectDispensationRequestUsecase {
  final DispensationRepository dispensationRepository;

  RejectDispensationRequestUsecase(this.dispensationRepository);

  Future<Either<Map<String, dynamic>, DispensationEntity>> call(
    int dispensationId,
    String rejectReason,
  ) async {
    return await dispensationRepository.rejectDispensationRequest(
        dispensationId, rejectReason);
  }
}
