import 'package:call_away/model/location.dart';
import 'package:call_away/provider/camera_image_provider.dart';
import 'package:call_away/services/location_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final locationProvider = StateNotifierProvider.autoDispose<LocationService, DeviceLocation>((ref) {
  return LocationService(ref);
});
