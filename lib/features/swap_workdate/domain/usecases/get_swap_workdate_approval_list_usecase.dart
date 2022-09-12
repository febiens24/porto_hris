import 'package:dartz/dartz.dart';

import '../entities/swap_workdate_entity.dart';
import '../repositories/swap_workdate_repository.dart';

class GetSwapWorkdateApprovalListUsecase {
  final SwapWorkdateRepository reprimandRepository;

  GetSwapWorkdateApprovalListUsecase(this.reprimandRepository);

  Future<Either<Map<String, dynamic>, SwapWorkdateEntity>> call() async {
    return await reprimandRepository.getSwapWorkdateApprovalList();
  }
}
