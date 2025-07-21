import 'package:knittda/src/domain/use_case/create_record_use_case.dart';
import 'package:knittda/src/domain/use_case/delete_record_use_case.dart';
import 'package:knittda/src/domain/use_case/get_record_use_case.dart';
import 'package:knittda/src/domain/use_case/get_records_use_case.dart';
import 'package:knittda/src/domain/use_case/update_record_use_case.dart';

class RecordUseCases {
  final CreateRecordUseCase createRecord;
  final DeleteRecordUseCase deleteRecord;
  final GetRecordUseCase getRecord;
  final GetRecordsUseCase getRecords;
  final UpdateRecordUseCase updateRecord;

  RecordUseCases({
    required this.createRecord,
    required this.deleteRecord,
    required this.getRecord,
    required this.getRecords,
    required this.updateRecord,
  });
}