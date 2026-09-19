import 'package:file_picker/file_picker.dart';

class FilePickerService {
  Future<PlatformFile?> pickCv() async {
    final files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf', 'docx'],
    );

    if (files.isEmpty) {
      return null;
    }

    return files.first;
  }
}
