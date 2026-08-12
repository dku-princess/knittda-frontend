import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/data/data_sources/analytics_service.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/domain/use_case/add_project_use_case.dart';
import 'package:knittda/src/domain/use_case/get_default_thumbnails_use_case.dart';
import 'package:knittda/src/domain/use_case/update_project_use_case.dart';
import 'package:knittda/src/presentation/project_add_edit/add_edit_project_event.dart';
import 'package:knittda/src/presentation/project_add_edit/add_edit_project_state.dart';
import 'package:knittda/src/presentation/project_add_edit/add_edit_project_ui_event.dart';

class AddEditProjectViewModel extends ChangeNotifier {
  final AddProjectUseCase _addProjectUseCase;
  final UpdateProjectUseCase _updateProjectUseCase;
  final GetDefaultThumbnailsUseCase _getDefaultThumbnailsUseCase;

  AddEditProjectViewModel(
    this._addProjectUseCase,
    this._updateProjectUseCase,
    this._getDefaultThumbnailsUseCase,
  ) {
    _loadDefaultThumbnails();
  }

  AddEditProjectState _state = AddEditProjectState(isLoading: false);

  AddEditProjectState get state => _state;

  final _eventController = StreamController<AddEditProjectUiEvent>();

  Stream<AddEditProjectUiEvent> get eventStream => _eventController.stream;

  Future<void> onEvent(AddEditProjectEvent event) async {
    switch (event) {
      case SaveProject(:final project, :final file, :final defaultThumbnailId):
        await _saveProject(
          project: project,
          file: file,
          defaultThumbnailId: defaultThumbnailId,
        );
    }
  }

  Future<void> _loadDefaultThumbnails() async {
    final result = await _getDefaultThumbnailsUseCase();

    switch (result) {
      case Success(:final data):
        _state = state.copyWith(defaultThumbnails: data);
        notifyListeners();
      case Error():
        _eventController.add(
          AddEditProjectUiEvent.showSnackBar("기본 이미지를 불러오지 못했어요."),
        );
    }
  }

  Future<void> _saveProject({
    required Project project,
    required XFile? file,
    int? defaultThumbnailId,
  }) async {
    if (state.isLoading) {
      return;
    }
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final Result<Project> result;

    if (project.id == null) {
      result = await _addProjectUseCase(
        project: project,
        file: file,
        defaultThumbnailId: defaultThumbnailId,
      );
    } else {
      result = await _updateProjectUseCase(
        project: project,
        file: file,
        defaultThumbnailId: defaultThumbnailId,
      );
    }

    switch (result) {
      case Success(:final data):
        if (project.id == null) {
          AnalyticsService.instance.logCreateProject();
        } else {
          AnalyticsService.instance.logEditProject(project.id.toString());
        }
        _eventController.add(AddEditProjectUiEvent.savedProject(data));
      case Error():
        _eventController.add(
          AddEditProjectUiEvent.showSnackBar("작품 저장을 저장하지 못했어요. 다시 시도해 주세요."),
        );
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
