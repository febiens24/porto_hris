import 'package:dartz/dartz.dart';

import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

class GetAttendanceApprovalHistoryListUsecase {
  final AttendanceRepository attendanceRepository;

  GetAttendanceApprovalHistoryListUsecase(this.attendanceRepository);

  Future<Either<Map<String, dynamic>, AttendanceEntity>> call() async {
    return await attendanceRepository.getAttendanceApprovalHistoryList();
  }
}
