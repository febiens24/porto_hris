import 'package:dartz/dartz.dart';
import '../entities/employee_attendance_summary_entity.dart';
import '../entities/employee_birthday_entity.dart';
import '../entities/employee_penalty_summary_entity.dart';

abstract class HomeRepository {
  Future<Either<Map<String, dynamic>, EmployeeAttendanceSummaryEntity>>
      getEmployeeAttendanceSummary();
  Future<Either<Map<String, dynamic>, EmployeePenaltySummaryEntity>>
      getEmployeePenaltySummary();
  Future<Either<Map<String, dynamic>, EmployeeBirthdayEntity>>
      getEmployeeBirthday();
}
