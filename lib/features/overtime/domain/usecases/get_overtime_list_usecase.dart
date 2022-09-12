import 'package:dartz/dartz.dart';

import '../entities/overtime_entity.dart';
import '../repositories/overtime_repository.dart';

class GetOvertimeListUsecase {
  final OvertimeRepository overtimeRepository;

  GetOvertimeListUsecase(this.overtimeRepository);

  Future<Either<Map<String, dynamic>, OvertimeEntity>> call({
    String? status,
    String? type,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  }) async {
    return await overtimeRepository.getOvertimeList(
      status: status,
      type: type,
      dateFrom: dateFrom,
      dateTo: dateTo,
      q: q,
      page: page,
    );
  }
}
