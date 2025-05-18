// void update(AuthViewModel auth, CreateRecordUseCase useCase) {
//   _auth    = auth;
//   _useCase = useCase;
//   notifyListeners();
// }

// void reset({bool all = false}) {
//   _created = null;
//   _error = null;
//   if (all) {
//     _gotRecord = null;
//     _gotRecords = null;
//   }
//   notifyListeners();
// }

// void reset({
//   bool clearCreated = true,
//   bool clearError = true,
//   bool clearGotRecord = false,
//   bool clearGotRecords = false,
// }) {
//   if (clearCreated) _created = null;
//   if (clearError) _error = null;
//   if (clearGotRecord) _gotRecord = null;
//   if (clearGotRecords) _gotRecords = null;
//
//   notifyListeners();
// }
// Map<String, dynamic> toJson() {
//   return {
//     'project': {
//       'projectId': id,
//       'designId': designId,
//       'nickname': nickname,
//       'customYarnInfo': customYarnInfo ?? '',
//       'customNeedleInfo': customNeedleInfo ?? '',
//       'startDate': startDate != null ? DateUtilsHelper.toHyphenFormat(startDate!) : null,
//       'endDate': endDate != null ? DateUtilsHelper.toHyphenFormat(endDate!) : null,
//       'goalDate': goalDate != null ? DateUtilsHelper.toHyphenFormat(goalDate!) : null,
//       'title': title,
//       'designer': designer,
//       'visible': false,
//     },
//     'file': file?.path,
//   };
// }
