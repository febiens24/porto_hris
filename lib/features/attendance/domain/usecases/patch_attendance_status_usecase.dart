import 'package:dartz/dartz.dart';

import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

class PatchAttendanceStatusUsecase {
  final AttendanceRepository attendanceRepository;

  PatchAttendanceStatusUsecase(this.attendanceRepository);

  Future<Either<Map<String, dynamic>, AttendanceEntity>> call(
    int attendanceId,
    String state,
    String? cancelReason,
  ) async {
    return await attendanceRepository.patchAttendanceStatus(
        attendanceId, state, cancelReason);
  }
}
