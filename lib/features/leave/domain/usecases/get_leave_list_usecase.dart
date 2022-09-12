import 'package:dartz/dartz.dart';

import '../entities/leave_entity.dart';
import '../repositories/leave_repository.dart';

class GetLeaveListUsecase {
  final LeaveRepository leaveRepository;

  GetLeaveListUsecase(this.leaveRepository);

  Future<Either<Map<String, dynamic>, LeaveEntity>> call({
    String? status,
    String? type,
    String? dateFrom,
    String? dateTo,
    String? q,
    int? page = 1,
  }) async {
    return await leaveRepository.getLeaveList(
      status: status,
      type: type,
      dateFrom: dateFrom,
      dateTo: dateTo,
      q: q,
      page: page,
    );
  }
}
