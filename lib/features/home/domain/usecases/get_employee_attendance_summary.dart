import 'package:dartz/dartz.dart';
import '../repositories/home_repository.dart';

import '../entities/employee_attendance_summary_entity.dart';

class GetEmployeeAttendanceSummary {
  final HomeRepository homeRepository;

  GetEmployeeAttendanceSummary(this.homeRepository);

  Future<Either<Map<String, dynamic>, EmployeeAttendanceSummaryEntity>>
      call() async {
    return await homeRepository.getEmployeeAttendanceSummary();
  }
}
