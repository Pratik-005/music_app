import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File?> pickImage() async {
  try {
    final filePickerRes = await FilePicker.pickFiles(type: FileType.image);
    if (filePickerRes != null) {
      return File(filePickerRes.files.first.xFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}
