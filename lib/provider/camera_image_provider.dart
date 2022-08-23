import 'package:call_away/services/camera_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
final cameraImageProvider = StateNotifierProvider.autoDispose<CameraService, XFile?>((ref) {
  return CameraService();
});