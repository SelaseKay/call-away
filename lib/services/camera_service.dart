import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CameraService extends StateNotifier<XFile?> {
  CameraService() : super(null);

  Future<XFile?> getImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    XFile? image;
    try {
      image = await picker.pickImage(source: ImageSource.camera);
      state = image;
    } catch (e) {
      print("Image picker exception: ${e.toString()}");
    }
    return image;
  }

  Future<XFile?> getImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    XFile? image;
    try {
      image = await picker.pickImage(source: ImageSource.gallery);
      state = image;
    } catch (e) {
      print("Image picker exception: ${e.toString()}");
    }
    return image!;
  }
}
