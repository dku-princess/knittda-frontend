import 'package:knittda/src/domain/use_case/create_work_use_case.dart';
import 'package:knittda/src/domain/use_case/delete_work_use_case.dart';
import 'package:knittda/src/domain/use_case/get_work_use_case.dart';
import 'package:knittda/src/domain/use_case/get_works_use_case.dart';
import 'package:knittda/src/domain/use_case/update_work_use_case.dart';

class WorkUseCases {
  final CreateWorkUseCase createWork;
  final DeleteWorkUseCase deleteWork;
  final GetWorkUseCase getWork;
  final GetWorksUseCase getWorks;
  final UpdateWorkUseCase updateWork;

  WorkUseCases({
    required this.createWork,
    required this.deleteWork,
    required this.getWork,
    required this.getWorks,
    required this.updateWork,
  });
}