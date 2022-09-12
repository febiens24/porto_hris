import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/authentication_repository.dart';

class CheckUserUsecase {
  final AuthenticationRepository authenticationRepository;

  const CheckUserUsecase({required this.authenticationRepository});

  Future<Either<Failure, bool?>?> call() async {
    return await authenticationRepository.hasUser();
  }
}
