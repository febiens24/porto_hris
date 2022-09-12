import '../../domain/entities/employee_birthday_entity.dart';

class EmployeeBirthdayModel extends EmployeeBirthdayEntity {
  const EmployeeBirthdayModel({
    required String status,
    required String message,
    required EmployeeBirthdayResultEntity result,
  }) : super(
          status: status,
          message: message,
          result: result,
        );

  factory EmployeeBirthdayModel.fromJson(Map<String, dynamic> json) =>
      EmployeeBirthdayModel(
        status: json['status'],
        message: json['message'],
        result: EmployeeBirthdayResultModel.fromJson(json['result']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'result': result,
      };
}

class EmployeeBirthdayResultModel extends EmployeeBirthdayResultEntity {
  const EmployeeBirthdayResultModel({
    required String summaryPeriod,
    required List<EmployeeEntity> datas,
  }) : super(
          summaryPeriod: summaryPeriod,
          datas: datas,
        );

  factory EmployeeBirthdayResultModel.fromJson(Map<String, dynamic> json) =>
      EmployeeBirthdayResultModel(
        summaryPeriod: json['periode'],
        datas: (json['data'] as List<dynamic>)
            .map((e) => EmployeeModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'periode': summaryPeriod,
        'data': datas,
      };
}

class EmployeeModel extends EmployeeEntity {
  const EmployeeModel({
    required int employeeId,
    required String employeeName,
    required String employeeBirthdayDate,
    required String employeePictureUrl,
    required String employeeDivision,
  }) : super(
          employeeId: employeeId,
          employeeName: employeeName,
          employeeBirthdayDate: employeeBirthdayDate,
          employeePictureUrl: employeePictureUrl,
          employeeDivision: employeeDivision,
        );

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        employeeId: json['EmployeeId'],
        employeeName: json['EmployeeName'],
        employeeBirthdayDate: json['EmployeeBirthdayDate'],
        employeeDivision: json['EmployeeDivision'],
        employeePictureUrl: json['EmployeePictureUrl'],
      );

  Map<String, dynamic> toJson() => {
        "EmployeeId": employeeId,
        "EmployeeName": employeeName,
        "EmployeeBirthdayDate": employeeBirthdayDate,
        "EmployeeDivision": employeeDivision,
        "EmployeePictureUrl": employeePictureUrl,
      };
}
