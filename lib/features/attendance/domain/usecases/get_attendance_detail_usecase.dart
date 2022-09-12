import 'package:dartz/dartz.dart';

import '../entities/attendance_detail_entity.dart';
import '../repositories/attendance_repository.dart';

class GetAttendanceDetailUsecase {
  final AttendanceRepository attendanceRepository;

  GetAttendanceDetailUsecase(this.attendanceRepository);

  Future<Either<Map<String, dynamic>, AttendanceDetailEntity>> call(
    int businessTripId,
  ) async {
    return await attendanceRepository.getAttendanceDetail(businessTripId);
  }
}
