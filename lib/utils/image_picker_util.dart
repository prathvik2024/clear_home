import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerUtil {
  static Future<String> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return "";
      return image.path;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
      return e.toString();
    }
  }
}
