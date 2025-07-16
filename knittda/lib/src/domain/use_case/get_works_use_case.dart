import 'package:flutter/material.dart';
//import 'package:knittda/src/data/models/work_model.dart';
import 'package:knittda/src/data/repositories/work_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class GetWorksUseCase {
  final WorkRepository _repository;

  GetWorksUseCase(
    this._repository,
  );

  Future<void> call() async {
    try {
      await _repository.getWorks();
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      debugPrint('GetWorksUseCase 오류: $e\n$stack');
      rethrow; // 호출 측에서 catch 가능하게 재던짐
    }
  }
}