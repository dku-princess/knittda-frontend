import 'dart:async';

import 'package:flutter/material.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/records.dart';
import 'package:knittda/src/domain/use_case_record/delete_record_use_case.dart';
import 'package:knittda/src/domain/use_case_record/get_record_use_case.dart';
import 'package:knittda/src/presentation/record_details/record_details_event.dart';
import 'package:knittda/src/presentation/record_details/record_details_state.dart';
import 'package:knittda/src/presentation/record_details/record_details_ui_event.dart';

class RecordDetailsViewModel extends ChangeNotifier {
  final GetRecordUseCase _getRecordUseCase;
  final DeleteRecordUseCase _deleteRecordUseCase;

  RecordDetailsState _state = RecordDetailsState(
    record: null,
    isLoading: false,
    isOwner: false,
    isChanged: false,
  );

  RecordDetailsState get state => _state;

  final _eventController = StreamController<RecordDetailsUiEvent>();

  Stream<RecordDetailsUiEvent> get eventStream => _eventController.stream;

  RecordDetailsViewModel(
    this._getRecordUseCase,
    this._deleteRecordUseCase, {
    required int recordId,
    required Records record,
    required bool isOwner,
  }) {
    _state = state.copyWith(isOwner: isOwner);
    _loadRecord(recordId: recordId, record: record);
  }

  Future<void> onEvent(RecordDetailsEvent event) async {
    switch (event) {
      case LoadRecord(:final recordId, :final record):
        await _loadRecord(recordId: recordId, record: record);
      case DeleteRecord(:final recordId):
        await _deleteRecord(recordId: recordId);
      case MarkChanged():
        _markChanged();
    }
  }

  void _markChanged() {
    _state = state.copyWith(isChanged: true);
    notifyListeners();
  }

  Future<void> _loadRecord({
    required int recordId,
    required Records record,
  }) async {
    _state = state.copyWith(record: record);
    notifyListeners();

    final Result<Records> result = await _getRecordUseCase(recordId: recordId);

    switch (result) {
      case Success(:final data):
        _state = state.copyWith(record: data);
      case Error(:final e):
        _eventController.add(RecordDetailsUiEvent.showSnackBar(e));
        _eventController.add(RecordDetailsUiEvent.deletedRecord());
    }

    notifyListeners();
  }

  Future<void> _deleteRecord({required int recordId}) async {
    if (!state.isOwner) return;

    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final Result<void> result = await _deleteRecordUseCase(recordId: recordId);

    switch (result) {
      case Success():
        _eventController.add(RecordDetailsUiEvent.deletedRecord());
      case Error(:final e):
        _eventController.add(RecordDetailsUiEvent.showSnackBar(e));
    }

    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }

  @override
  void dispose() {
    _eventController.close();
    super.dispose();
  }
}
