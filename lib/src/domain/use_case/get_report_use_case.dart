import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/report.dart';
import 'package:knittda/src/domain/repository/report_api_repository.dart';

class GetReportUseCase {
  final ReportApiRepository _reportApiRepository;

  GetReportUseCase(this._reportApiRepository);

  Future<Result<Report>> call() async {
    final Result<Report> result = await _reportApiRepository.getReport();

    return switch (result) {
      Success<Report>() => Result.success(result.data),
      Error<Report>() => Result.error(result.e),
    };
  }
}
