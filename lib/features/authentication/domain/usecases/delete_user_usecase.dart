import '../repositories/authentication_repository.dart';

class DeleteUserUsecase {
  final AuthenticationRepository authenticationRepository;

  const DeleteUserUsecase({required this.authenticationRepository});

  Future<void> call() async {
    return await authenticationRepository.deleteUser();
  }
}
