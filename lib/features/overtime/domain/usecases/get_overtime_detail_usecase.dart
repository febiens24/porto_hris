import 'package:dartz/dartz.dart';

import '../entities/overtime_detail_entity.dart';
import '../repositories/overtime_repository.dart';

class GetOvertimeDetailUsecase {
  final OvertimeRepository overtimeRepository;

  GetOvertimeDetailUsecase(this.overtimeRepository);

  Future<Either<Map<String, dynamic>, OvertimeDetailEntity>> call(
    int businessTripId,
  ) async {
    return await overtimeRepository.getOvertimeDetail(businessTripId);
  }
}
