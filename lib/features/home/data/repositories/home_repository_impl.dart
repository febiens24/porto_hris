import 'package:dio/dio.dart';
import '../datasources/home_api_services.dart';
import '../models/employee_attendance_summary_model.dart';
import '../../domain/entities/employee_penalty_summary_entity.dart';
import '../../domain/entities/employee_birthday_entity.dart';
import '../../domain/entities/employee_attendance_summary_entity.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/home_repository.dart';

import '../../../../core/storage.dart';
import '../models/employee_birthday_model.dart';
import '../models/employee_penalty_summary_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeApiServices homeApiServices;
  final SecureStorage secureStorage;

  HomeRepositoryImpl({
    required this.homeApiServices,
    required this.secureStorage,
  });

  @override
  Future<Either<Map<String, dynamic>, EmployeeAttendanceSummaryEntity>>
      getEmployeeAttendanceSummary() async {
    try {
      final userId = await secureStorage.getUser();
      final result = await homeApiServices.fetchHomepageAPI(
        userId!,
        data: "attendance_summary",
      );
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final res =
            EmployeeAttendanceSummaryResultModel.fromJson(result["result"]);

        final EmployeeAttendanceSummaryModel attendanceSummary =
            EmployeeAttendanceSummaryModel(
          status: result["status"],
          message: result["message"],
          result: res,
        );
        return Right(attendanceSummary);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }

  @override
  Future<Either<Map<String, dynamic>, EmployeeBirthdayEntity>>
      getEmployeeBirthday() async {
    try {
      final userId = await secureStorage.getUser();
      final result = await homeApiServices.fetchHomepageAPI(
        userId!,
        data: "birthday",
      );
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final res = EmployeeBirthdayResultModel.fromJson(result["result"]);

        final EmployeeBirthdayModel employeeBirthday = EmployeeBirthdayModel(
          status: result["status"],
          message: result["message"],
          result: res,
        );
        return Right(employeeBirthday);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }

  @override
  Future<Either<Map<String, dynamic>, EmployeePenaltySummaryEntity>>
      getEmployeePenaltySummary() async {
    try {
      final userId = await secureStorage.getUser();
      final result = await homeApiServices.fetchHomepageAPI(
        userId!,
        data: "penalty_summary",
      );
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final res =
            EmployeePenaltySummaryResultModel.fromJson(result["result"]);

        final EmployeePenaltySummaryModel penaltySummary =
            EmployeePenaltySummaryModel(
          status: result["status"],
          message: result["message"],
          result: res,
        );
        return Right(penaltySummary);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }
}
