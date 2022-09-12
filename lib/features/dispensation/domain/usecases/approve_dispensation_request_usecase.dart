import 'package:dartz/dartz.dart';
import '../entities/dispensation_entity.dart';
import '../repositories/dispensation_repository.dart';

class ApproveDispensationRequestUsecase {
  final DispensationRepository dispensationRepository;

  ApproveDispensationRequestUsecase(this.dispensationRepository);

  Future<Either<Map<String, dynamic>, DispensationEntity>> call(
    int dispensationId,
  ) async {
    return await dispensationRepository
        .approveDispensationRequest(dispensationId);
  }
}
