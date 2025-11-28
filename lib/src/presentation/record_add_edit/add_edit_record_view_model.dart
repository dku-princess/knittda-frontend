import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/records.dart';
import 'package:knittda/src/domain/use_case_record/add_record_use_case.dart';
import 'package:knittda/src/domain/use_case_record/update_record_use_case.dart';
import 'package:knittda/src/domain/use_case_record/get_question_use_case.dart';
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
      errorMessage: null,
    ),
  );

  AddEditRecordState get state => _state;

  final _eventController = StreamController<AddEditRecordUiEvent>();

  Stream<AddEditRecordUiEvent> get eventStream => _eventController.stream;

  Future<void> onEvent(AddEditRecordEvent event) async {
    switch (event) {
      case SaveRecord(:final record, :final deleteImageIds, :final files):
        await _saveRecord(
          record: record,
          deleteImageIds: deleteImageIds,
          files: files,
        );
    }
  }

  Future<void> _saveRecord({
    required Records record,
    List<int>? deleteImageIds,
    required List<XFile>? files,
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
      );
    }

    switch (result) {
      case Success(:final data):
        _eventController.add(AddEditRecordUiEvent.savedRecord(data));
      case Error(:final e):
        _eventController.add(AddEditRecordUiEvent.showSnackBar(e));
    }

    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }

  Future<void> _loadQuestion({required int projectId}) async {
    _state = state.copyWith(
      questionState: state.questionState.copyWith(
        isLoading: true,
        errorMessage: null,
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
        _state = state.copyWith(
          questionState: state.questionState.copyWith(errorMessage: e),
        );
        _eventController.add(AddEditRecordUiEvent.showSnackBar(e));
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
