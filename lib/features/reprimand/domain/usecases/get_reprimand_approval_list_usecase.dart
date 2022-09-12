import 'package:dartz/dartz.dart';

import '../entities/reprimand_entity.dart';
import '../repositories/reprimand_repository.dart';

class GetReprimandApprovalListUsecase {
  final ReprimandRepository reprimandRepository;

  GetReprimandApprovalListUsecase(this.reprimandRepository);

  Future<Either<Map<String, dynamic>, ReprimandEntity>> call() async {
    return await reprimandRepository.getReprimandApprovalList();
  }
}
