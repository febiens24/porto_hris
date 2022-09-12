import 'package:dartz/dartz.dart';
import '../repositories/home_repository.dart';

import '../entities/employee_penalty_summary_entity.dart';

class GetEmployeePenaltySummary {
  final HomeRepository homeRepository;

  GetEmployeePenaltySummary(this.homeRepository);

  Future<Either<Map<String, dynamic>, EmployeePenaltySummaryEntity>>
      call() async {
    return await homeRepository.getEmployeePenaltySummary();
  }
}
