import 'package:file_picker/file_picker.dart';

class FilePickerService {
  static Future<String?> selectPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      return result.files.single.path;
    } else {
      return null;
    }
  }
}
