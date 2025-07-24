import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/report_model.dart';
import 'package:knittda/src/data/repositories/report_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class GetReportUseCase {
  final ReportRepository _repository;

  GetReportUseCase(
    this._repository,
  );

  Future<ReportModel> call () async {
    try {
      final report = await _repository.getReport();
      return report;
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      debugPrint('GetReportUseCase 오류: $e\n$stack');
      rethrow; // 호출 측에서 catch 가능하게 재던짐
    }
  }
}