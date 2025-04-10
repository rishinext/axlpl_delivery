import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<void> pickImage(ImageSource source, final imageFile) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: source);

  if (pickedFile != null) {
    imageFile.value = File(pickedFile.path);
  }
}
