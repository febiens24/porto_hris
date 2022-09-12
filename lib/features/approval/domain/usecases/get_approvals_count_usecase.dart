import 'package:dartz/dartz.dart';

import '../entities/approvals_entity.dart';
import '../repositories/approvals_repository.dart';

class GetApprovalsCountUsecase {
  final ApprovalsRepository approvalsRepository;

  GetApprovalsCountUsecase(this.approvalsRepository);

  Future<Either<Map<String, dynamic>, ApprovalsEntity>> call() async {
    return await approvalsRepository.getApprovalsCount();
  }
}
