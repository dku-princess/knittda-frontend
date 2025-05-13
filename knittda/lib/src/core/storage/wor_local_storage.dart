import 'package:shared_preferences/shared_preferences.dart';

class WorkLocalStorageHelper {
  static const _customDesign = 'customDesign_';
  static const _customDesigner = 'customDesigner_';

  static Future<void> saveCustomInfo({
    required int workId,
    required String customDesign,
    required String customDesigner,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$_customDesign$workId', customDesign);
    await prefs.setString('$_customDesigner$workId', customDesigner);
  }

  static Future<Map<String, String?>> getCustomInfo(int workId) async {
    final prefs = await SharedPreferences.getInstance();
    final design = prefs.getString('$_customDesign$workId');
    final designer = prefs.getString('$_customDesigner$workId');
    return {
      'customDesign': design,
      'customDesigner': designer,
    };
  }

  static Future<void> removeCustomInfo(int workId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_customDesign$workId');
    await prefs.remove('$_customDesigner$workId');
  }
}