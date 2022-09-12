import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/authentication_repository.dart';

class GetUserUsecase {
  final AuthenticationRepository authenticationRepository;

  const GetUserUsecase({required this.authenticationRepository});

  Future<Either<Failure, String>> call() async {
    return await authenticationRepository.getUser();
  }
}
