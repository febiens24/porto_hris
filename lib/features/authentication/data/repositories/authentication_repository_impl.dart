import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/shared_prefs_services.dart';
import '../../../../core/storage.dart';
import '../../domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final SecureStorage secureStorage;
  final SharedPreferencesServices sharedPreferencesServices;

  AuthenticationRepositoryImpl({
    required this.secureStorage,
    required this.sharedPreferencesServices,
  });

  @override
  Future<void> deleteAllData() async {
    try {
      secureStorage.deleteAll();
    } catch (e) {
      StorageFailure(errorMessage: 'Unexpected error');
    }
  }

  @override
  Future<void> deleteUser() async {
    try {
      secureStorage.deleteUser();
    } catch (e) {
      StorageFailure(errorMessage: 'User not found');
    }
  }

  @override
  Future<Either<Failure, String>> getUser() async {
    try {
      final user = await secureStorage.getUser();
      if (user != null) {
        return Right(user);
      } else {
        return Left(StorageFailure(errorMessage: 'User not found'));
      }
    } catch (e) {
      return Left(StorageFailure(errorMessage: 'Unexpected error'));
    }
  }

  @override
  Future<Either<Failure, bool>> hasUser() async {
    try {
      var hasUser = await secureStorage.hasUser();
      if (hasUser) {
        return Right(hasUser);
      } else {
        return Left(StorageFailure(errorMessage: 'not found'));
      }
    } catch (e) {
      return Left(StorageFailure(errorMessage: 'Unexpected error'));
    }
  }

  @override
  Future<void> persistUser(String user) async {
    try {
      await secureStorage.persistUser(user);
    } catch (e) {
      StorageFailure(errorMessage: 'UserId not found');
    }
  }

  @override
  Future<Either<Failure, bool>> getIntroductionScreenStatus() async {
    try {
      final value = await sharedPreferencesServices.getIsSeenValue();
      if (value != null) {
        return Right(value);
      } else {
        return Left(StorageFailure(errorMessage: 'key not found'));
      }
    } catch (e) {
      return Left(StorageFailure(errorMessage: 'Unexpected error'));
    }
  }

  @override
  void saveIntroductionStatus(bool isSeen) {
    try {
      sharedPreferencesServices.setIsSeen(isSeen);
    } catch (e) {
      StorageFailure(errorMessage: 'Unexpected error');
    }
  }

  @override
  Future<Either<Failure, bool?>> getInstallationStatus() async {
    try {
      final value = await sharedPreferencesServices.getInstallationStatus();
      return Right(value);
    } catch (e) {
      return Left(StorageFailure(errorMessage: 'Unexpected error'));
    }
  }

  @override
  void updateInstallationStatus(bool status) {
    try {
      sharedPreferencesServices.setInstallationStatus(status);
    } catch (e) {
      StorageFailure(errorMessage: 'Unexpected error');
    }
  }
}
