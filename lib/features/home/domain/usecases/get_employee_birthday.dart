import 'package:dartz/dartz.dart';
import '../entities/employee_birthday_entity.dart';
import '../repositories/home_repository.dart';

class GetEmployeeBirthday {
  final HomeRepository homeRepository;

  GetEmployeeBirthday(this.homeRepository);

  Future<Either<Map<String, dynamic>, EmployeeBirthdayEntity>> call() async {
    return await homeRepository.getEmployeeBirthday();
  }
}
