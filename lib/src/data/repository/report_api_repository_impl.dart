import 'package:knittda/src/core/utils/date_utils.dart';
import 'package:knittda/src/data/data_sources/report_api.dart';
import 'package:knittda/src/data/data_sources/report_data_source.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/report.dart';
import 'package:knittda/src/domain/repository/report_api_repository.dart';

class ReportApiRepositoryImpl implements ReportApiRepository{
  final ReportApi _api;
  final ReportDataSource _local;

  ReportApiRepositoryImpl(this._api, this._local);

  @override
  Future<Result<Report>> getReport() async {
    final weekId = DateUtilsHelper.getCurrentWeekId();

    final cached = await _local.readData(weekId);
    if (cached != null) {
      return Result.success(cached);
    }

    final Result<Map<String, dynamic>> result = await _api.getReport();

    return switch (result) {
      Success(:final data) => _saveReport(data, weekId),
      Error(:final e) => Result.error(e),
    };
  }

  @override
  Future<void> clearReport() async {
    await _local.clearData();
  }

  Future<Result<Report>> _saveReport(Map<String, dynamic> data, String weekId) async {
    final report = Report.fromJson(data);
    await _local.saveData(weekId, report);
    return Result.success(report);
  }

}