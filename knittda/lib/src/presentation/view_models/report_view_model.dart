import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/report_model.dart';
import 'package:knittda/src/domain/use_case/get_report_use_case.dart';

class ReportViewModel extends ChangeNotifier {
  final GetReportUseCase getReportUseCase;

  ReportViewModel(
    this.getReportUseCase,
  );

  ReportModel? _report;
  ReportModel? get report => _report;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<bool> fetchReport() async {
    if (_report != null) return true;
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _report = await getReportUseCase.call();
      notifyListeners();
      return true;
    } catch (e) {
      _error = "리포트를 불러오는데 실패했습니다.";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}