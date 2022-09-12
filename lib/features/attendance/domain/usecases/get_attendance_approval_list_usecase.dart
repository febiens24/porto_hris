import 'package:dartz/dartz.dart';

import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

class GetAttendanceApprovalListUsecase {
  final AttendanceRepository reprimandRepository;

  GetAttendanceApprovalListUsecase(this.reprimandRepository);

  Future<Either<Map<String, dynamic>, AttendanceEntity>> call() async {
    return await reprimandRepository.getAttendanceApprovalList();
  }
}
