import 'package:flutter/material.dart';
import 'package:knittda/src/data/models/report_model.dart';
import 'package:knittda/src/domain/use_case/get_report_use_case.dart';
import 'package:knittda/src/presentation/view_models/auth_view_model.dart';

class ReportViewModel extends ChangeNotifier {
  final AuthViewModel _auth;
  final GetReportUseCase _getReportUseCase;

  ReportViewModel({
    required AuthViewModel authViewModel,
    required GetReportUseCase getReportUseCase,
  }) : _auth = authViewModel,
       _getReportUseCase = getReportUseCase;

  ReportModel? _report;
  ReportModel? get report => _report;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<bool> fetchReport({bool forceRefresh = false}) async {
    if (_report != null && !forceRefresh) return true;

    final token = _auth.jwt;
    if (token == null) {
      _error = '로그인이 필요합니다.';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _getReportUseCase(token, forceRefresh: forceRefresh);
      _report = result;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}