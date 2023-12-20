import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static final _picker = ImagePicker();

  static Future<File?> selectImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  static Future<List<File>?> selectMultipleImagesFromGallery({int? maxImages}) async {
    List<XFile>? pickedFiles = await _picker.pickMultiImage(
      maxWidth: 1920,
      maxHeight: 1200,
      imageQuality: 80
    );

    if (pickedFiles != null) {
      List<File> images = pickedFiles.map((file) => File(file.path)).toList();
      return images;
    } else {
      return null;
    }
  }
}
