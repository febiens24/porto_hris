import '../repositories/authentication_repository.dart';

class SaveUserUsecase {
  final AuthenticationRepository authenticationRepository;

  const SaveUserUsecase({required this.authenticationRepository});

  Future<void> call(String user) async {
    return await authenticationRepository.persistUser(user);
  }
}
