import 'package:dartz/dartz.dart';

import '../entities/dispensation_detail_entity.dart';
import '../repositories/dispensation_repository.dart';

class GetDispensationDetailUsecase {
  final DispensationRepository dispensationRepository;

  GetDispensationDetailUsecase(this.dispensationRepository);

  Future<Either<Map<String, dynamic>, DispensationDetailEntity>> call(
    int dispensationId,
  ) async {
    return await dispensationRepository.getDispensationDetail(dispensationId);
  }
}
