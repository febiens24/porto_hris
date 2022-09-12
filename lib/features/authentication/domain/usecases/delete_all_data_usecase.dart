import '../repositories/authentication_repository.dart';

class DeleteAllDataUsecase {
  final AuthenticationRepository authenticationRepository;

  const DeleteAllDataUsecase({required this.authenticationRepository});

  Future<void> call() async {
    return await authenticationRepository.deleteAllData();
  }
}
