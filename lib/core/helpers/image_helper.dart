import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageHelper {
  static final picker = ImagePicker();

  static Future<File?> pickCropImage() async {
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );

    if (picked == null) return null;

    CroppedFile? cropped = await ImageCropper().cropImage(
      sourcePath: picked.path,
      compressQuality: 90,
      uiSettings: [
        AndroidUiSettings(toolbarTitle: 'Adjust photo', lockAspectRatio: false),
        IOSUiSettings(title: 'Adjust photo'),
      ],
    );

    if (cropped == null) return null;

    return File(cropped.path);
  }
}
