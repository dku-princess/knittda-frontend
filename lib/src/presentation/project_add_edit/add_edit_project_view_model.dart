import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knittda/src/data/data_sources/result.dart';
import 'package:knittda/src/domain/model/project.dart';
import 'package:knittda/src/domain/use_case/add_project_use_case.dart';
import 'package:knittda/src/domain/use_case/update_project_use_case.dart';
import 'package:knittda/src/presentation/project_add_edit/add_edit_project_event.dart';
import 'package:knittda/src/presentation/project_add_edit/add_edit_project_state.dart';
import 'package:knittda/src/presentation/project_add_edit/add_edit_project_ui_event.dart';

class AddEditProjectViewModel extends ChangeNotifier {
  final AddProjectUseCase _addProjectUseCase;
  final UpdateProjectUseCase _updateProjectUseCase;

  AddEditProjectViewModel(this._addProjectUseCase, this._updateProjectUseCase);

  AddEditProjectState _state = AddEditProjectState(isLoading: false);

  AddEditProjectState get state => _state;

  final _eventController = StreamController<AddEditProjectUiEvent>();

  Stream<AddEditProjectUiEvent> get eventStream => _eventController.stream;

  Future<void> onEvent(AddEditProjectEvent event) async {
    switch (event) {
      case SaveProject(:final project, :final file):
        await _saveProject(project: project, file: file);
    }
  }

  Future<void> _saveProject({
    required Project project,
    required XFile? file,
  }) async {
    if (state.isLoading) {
      return;
    }

    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final Result<Project> result;

    if (project.id == null) {
      result = await _addProjectUseCase(project: project, file: file);
    } else {
      result = await _updateProjectUseCase(project: project, file: file);
    }

    switch (result) {
      case Success():
        _eventController.add(AddEditProjectUiEvent.savedProject());
      case Error(:final e):
        _eventController.add(AddEditProjectUiEvent.showSnackBar(e));
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
