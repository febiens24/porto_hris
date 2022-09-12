import 'package:dartz/dartz.dart';

import '../entities/overtime_entity.dart';
import '../repositories/overtime_repository.dart';

class GetOvertimeApprovalHistoryListUsecase {
  final OvertimeRepository overtimeRepository;

  GetOvertimeApprovalHistoryListUsecase(this.overtimeRepository);

  Future<Either<Map<String, dynamic>, OvertimeEntity>> call({
    String? status,
    String? type,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page,
  }) async {
    return await overtimeRepository.getOvertimeApprovalHistoryList(
      status: status,
      type: type,
      dateFrom: dateFrom,
      dateTo: dateTo,
      q: q,
      page: page,
    );
  }
}
