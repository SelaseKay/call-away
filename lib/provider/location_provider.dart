import 'package:call_away/services/location_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final locationProvider = StateNotifierProvider.autoDispose<LocationService, DeviceLocationState>((ref) {
  return LocationService(ref);
});
