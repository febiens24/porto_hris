import 'package:dartz/dartz.dart';

import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

class GetAttendanceListUsecase {
  final AttendanceRepository attendanceRepository;

  GetAttendanceListUsecase(this.attendanceRepository);

  Future<Either<Map<String, dynamic>, AttendanceEntity>> call() async {
    return await attendanceRepository.getAttendanceList();
  }
}
