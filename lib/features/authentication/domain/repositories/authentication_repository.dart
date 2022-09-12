import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, bool?>>? hasUser();

  Future<void> persistUser(String user);

  Future<void> deleteUser();

  Future<Either<Failure, String>> getUser();

  Future<void> deleteAllData();

  void saveIntroductionStatus(bool isSeen);

  void updateInstallationStatus(bool isFreshInstall);

  Future<Either<Failure, bool?>> getInstallationStatus();

  Future<Either<Failure, bool?>> getIntroductionScreenStatus();
}
