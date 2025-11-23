import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/report.dart';

abstract class ReportApiRepository {
  Future<Result<Report>> getReport();

  Future<void> clearReport();
}