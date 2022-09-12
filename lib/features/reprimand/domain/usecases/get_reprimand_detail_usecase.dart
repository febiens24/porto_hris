import 'package:dartz/dartz.dart';

import '../entities/reprimand_detail_entity.dart';
import '../repositories/reprimand_repository.dart';

class GetReprimandDetailUsecase {
  final ReprimandRepository reprimandRepository;

  GetReprimandDetailUsecase(this.reprimandRepository);

  Future<Either<Map<String, dynamic>, ReprimandDetailEntity>> call(
    int businessTripId,
  ) async {
    return await reprimandRepository.getReprimandDetail(businessTripId);
  }
}
