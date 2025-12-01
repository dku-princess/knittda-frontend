import 'dart:async';

import 'package:flutter/material.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/report.dart';
import 'package:knittda/src/domain/use_case/get_report_use_case.dart';
import 'package:knittda/src/presentation/report/report_state.dart';

class ReportViewModel extends ChangeNotifier {
  final GetReportUseCase _getReportUseCase;

  ReportState _state = ReportState(report: null, isLoading: false, errorMessage: null);

  ReportState get state => _state;

  ReportViewModel(this._getReportUseCase) {
    _loadReport();
  }

  Future<void> _loadReport() async {
    _state = state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    final Result<Report> result = await _getReportUseCase();

    switch (result) {
      case Success(:final data):
        _state = state.copyWith(report: data);
      case Error(:final e):
        _state = state.copyWith(errorMessage: e);
    }

    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }
}
