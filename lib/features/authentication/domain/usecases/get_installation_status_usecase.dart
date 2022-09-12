import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/authentication_repository.dart';

class GetInstallationStatusUsecase {
  final AuthenticationRepository authenticationRepository;

  const GetInstallationStatusUsecase({required this.authenticationRepository});

  Future<Either<Failure, bool?>> call() async {
    return await authenticationRepository.getInstallationStatus();
  }
}
