import 'package:equatable/equatable.dart';

class EmployeeBirthdayEntity extends Equatable {
  final String status;
  final String message;
  final EmployeeBirthdayResultEntity result;

  const EmployeeBirthdayEntity({
    required this.status,
    required this.message,
    required this.result,
  });

  @override
  List<Object?> get props => [
        status,
        message,
        result,
      ];
}

class EmployeeBirthdayResultEntity extends Equatable {
  final String summaryPeriod;
  final List<EmployeeEntity> datas;

  const EmployeeBirthdayResultEntity({
    required this.summaryPeriod,
    required this.datas,
  });

  @override
  List<Object?> get props => [
        summaryPeriod,
        datas,
      ];
}

class EmployeeEntity extends Equatable {
  final int employeeId;
  final String employeeName;
  final String employeeBirthdayDate;
  final String employeePictureUrl;
  final String employeeDivision;

  const EmployeeEntity({
    required this.employeeId,
    required this.employeeName,
    required this.employeeBirthdayDate,
    required this.employeePictureUrl,
    required this.employeeDivision,
  });

  @override
  List<Object?> get props => [
        employeeId,
        employeeName,
        employeeBirthdayDate,
        employeePictureUrl,
        employeeDivision,
      ];
}
