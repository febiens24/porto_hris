import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/storage.dart';
import '../../domain/entities/approvals_entity.dart';
import '../../domain/repositories/approvals_repository.dart';
import '../datasources/approvals_api_services.dart';
import '../models/approvals_model.dart';

class ApprovalsRepositoryImpl implements ApprovalsRepository {
  final ApprovalsApiServices approvalsApiServices;
  final SecureStorage secureStorage;

  ApprovalsRepositoryImpl(this.approvalsApiServices, this.secureStorage);
  @override
  Future<Either<Map<String, dynamic>, ApprovalsEntity>>
      getApprovalsCount() async {
    try {
      final userId = await secureStorage.getUser();
      final result = await approvalsApiServices.fetchApprovalsCount(userId!);
      if (result["result"] is String) {
        return Left({
          "status": result["status"].toString(),
          "result": result["result"].toString(),
        });
      } else {
        final approvals = ApprovalsResultModel.fromJson(result["result"]);

        final ApprovalsModel attendanceDetail = ApprovalsModel(
          status: result["status"],
          message: result["message"],
          result: approvals,
        );
        return Right(attendanceDetail);
      }
    } on DioError catch (e) {
      return Left({
        "status": e.message,
        "result": e.response!.data,
      });
    }
  }
}
