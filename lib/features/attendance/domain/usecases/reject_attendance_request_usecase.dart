import 'package:dartz/dartz.dart';

import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

class RejectAttendanceRequestUsecase {
  final AttendanceRepository attendanceRepository;

  RejectAttendanceRequestUsecase(this.attendanceRepository);

  Future<Either<Map<String, dynamic>, AttendanceEntity>> call(
    int attendanceId,
    String rejectReason,
  ) async {
    return await attendanceRepository.rejectAttendanceRequest(
        attendanceId, rejectReason);
  }
}
