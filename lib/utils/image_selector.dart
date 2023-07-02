import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageSelector {
  final ImagePicker _picker;

  ImageSelector({
    ImagePicker? imagePicker,
  }) : _picker = imagePicker ?? ImagePicker();

  Future<File?> selectImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return File(image!.path);
  }
}
