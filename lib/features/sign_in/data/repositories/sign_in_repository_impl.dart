import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/entities/user_error_entity.dart';
import '../../domain/repositories/sign_in_repository.dart';
import '../datasources/sign_in_datasource.dart';
import '../models/user_model.dart';

class SignInRepositoryImpl implements SignInRepository {
  final SignInApiServices signInApiServices;

  SignInRepositoryImpl({required this.signInApiServices});

  @override
  Future<Either<UserErrorEntity, UserEntity>> staffSignIn(
    String username,
    String password,
  ) async {
    try {
      final result = await signInApiServices.staffLogin(username, password);
      if (result["result"] is String) {
        return Left(
          UserErrorEntity(
            status: result["status"].toString(),
            result: result["result"].toString(),
          ),
        );
      } else {
        final userData = UserResultModel.fromJson(result["result"]);
        final UserModel user = UserModel(
          status: result["status"],
          result: userData,
        );
        return Right(user);
      }
    } on DioError catch (e) {
      return Left(
        UserErrorEntity(
          status: e.response!.statusCode.toString(),
          result: e.message,
        ),
      );
    }
  }
}
