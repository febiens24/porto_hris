import 'package:dartz/dartz.dart';

import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

class ApproveAttendanceRequestUsecase {
  final AttendanceRepository attendanceRepository;

  ApproveAttendanceRequestUsecase(this.attendanceRepository);

  Future<Either<Map<String, dynamic>, AttendanceEntity>> call(
    int attendanceId,
  ) async {
    return await attendanceRepository.approveAttendanceRequest(attendanceId);
  }
}
