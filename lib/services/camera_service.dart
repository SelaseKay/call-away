import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CameraService extends StateNotifier<XFile?> {
  CameraService() : super(null);

  Future<void> getImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    try {
      XFile? image = await picker.pickImage(source: ImageSource.camera);
      state = image;
    } catch (e) {
      print("Image picker exception: ${e.toString()}");
    }
  }

  Future<void> getImageFromGallery() async{
     final ImagePicker picker = ImagePicker();
    try {
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      state = image;
    } catch (e) {
      print("Image picker exception: ${e.toString()}");
    } 
  }
}
