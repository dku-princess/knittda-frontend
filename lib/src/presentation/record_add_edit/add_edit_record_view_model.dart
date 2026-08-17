import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/data/data_sources/analytics_service.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/records.dart';
import 'package:knittda/src/domain/use_case/add_record_use_case.dart';
import 'package:knittda/src/domain/use_case/update_record_use_case.dart';
import 'package:knittda/src/domain/use_case/get_question_use_case.dart';
import 'package:knittda/src/presentation/record_add_edit/add_edit_record_event.dart';
import 'package:knittda/src/presentation/record_add_edit/add_edit_record_state.dart';
import 'package:knittda/src/presentation/record_add_edit/add_edit_record_ui_event.dart';
import 'package:knittda/src/presentation/record_add_edit/question_state.dart';

class AddEditRecordViewModel extends ChangeNotifier {
  final AddRecordUseCase _addRecordUseCase;
  final UpdateRecordUseCase _updateRecordUseCase;
  final GetQuestionUseCase _getQuestionUseCase;
  final int projectId;

  AddEditRecordViewModel(
    this._addRecordUseCase,
    this._updateRecordUseCase,
    this._getQuestionUseCase, {
    required this.projectId,
  }) {
    _loadQuestion(projectId: projectId);
  }

  AddEditRecordState _state = AddEditRecordState(
    isLoading: false,
    questionState: QuestionState(
      question: '',
      isLoading: false,
    ),
  );

  AddEditRecordState get state => _state;

  final _eventController = StreamController<AddEditRecordUiEvent>();

  Stream<AddEditRecordUiEvent> get eventStream => _eventController.stream;

  Future<void> onEvent(AddEditRecordEvent event) async {
    switch (event) {
      case SaveRecord(
          :final record,
          :final deleteImageIds,
          :final files,
          :final imageOrder,
        ):
        await _saveRecord(
          record: record,
          deleteImageIds: deleteImageIds,
          files: files,
          imageOrder: imageOrder,
        );
    }
  }

  Future<void> _saveRecord({
    required Records record,
    List<int>? deleteImageIds,
    required List<XFile>? files,
    List<Map<String, dynamic>>? imageOrder,
  }) async {
    if (state.isLoading) {
      return;
    }
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final Result<Records> result;

    if (record.id == null) {
      result = await _addRecordUseCase(record: record, files: files);
    } else {
      result = await _updateRecordUseCase(
        record: record,
        deleteImageIds: deleteImageIds,
        files: files,
        imageOrder: imageOrder,
      );
    }

    switch (result) {
      case Success(:final data):
        if (record.id == null) {
          AnalyticsService.instance.logAddRecord(projectId.toString());
        } else {
          AnalyticsService.instance.logEditRecord(record.id.toString());
        }
        _eventController.add(AddEditRecordUiEvent.savedRecord(data));
      case Error():
        _eventController.add(AddEditRecordUiEvent.showSnackBar("기록을 저장하지 못했어요. 다시 시도해 주세요."));
    }

    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }

  Future<void> _loadQuestion({required int projectId}) async {
    _state = state.copyWith(
      questionState: state.questionState.copyWith(
        isLoading: true,
      ),
    );
    notifyListeners();

    final Result<String> result = await _getQuestionUseCase(
      projectId: projectId,
    );

    switch (result) {
      case Success(:final data):
        _state = state.copyWith(
          questionState: state.questionState.copyWith(question: data),
        );
      case Error(:final e):
        // 질문 조회 실패는 기록 작성 동작에 영향이 없으므로
        // 사용자에게 별도 안내(에러 메시지/스낵바)를 하지 않는다.
        // 다만 운영 중 조회 실패를 추적할 수 있도록 디버그 로그는 남긴다.
        debugPrint('질문 조회 실패: $e');
    }

    _state = state.copyWith(
      questionState: state.questionState.copyWith(isLoading: false),
    );
    notifyListeners();
  }

  @override
  void dispose() {
    _eventController.close();
    super.dispose();
  }
}
