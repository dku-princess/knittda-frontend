import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/report.dart';

part 'report_state.freezed.dart';

@freezed
abstract class ReportState with _$ReportState {
  factory ReportState({
    required Report? report,
    required bool isLoading,
    String? errorMessage,
  }) = _ReportState;
}
