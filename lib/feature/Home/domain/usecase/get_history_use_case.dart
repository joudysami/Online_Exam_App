import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/feature/Home/domain/entity/history_entity.dart';
import 'package:exam_app/feature/Home/domain/repo/home_repo.dart';

class GetHistoryUseCase {
  final HomeRepo homeRepo;
  GetHistoryUseCase(this.homeRepo);
    Future<BaseResponse<List<HistoryEntity>>> call() {
      return homeRepo.getHistory();
    }

  }