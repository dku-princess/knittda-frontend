import 'package:flutter/material.dart';
//import 'package:knittda/src/data/models/work_model.dart';
import 'package:knittda/src/data/repositories/work_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class GetWorksUseCase {
  final WorkRepository workRepositories;

  GetWorksUseCase({
    required this.workRepositories,
  });

  Future<void> call(String accessToken) async {
    try {
      await workRepositories.getWorks(accessToken);
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      debugPrint('GetWorksUseCase 오류: $e\n$stack');
      rethrow; // 호출 측에서 catch 가능하게 재던짐
    }
  }
}