import 'package:call_away/model/location.dart';
import 'package:call_away/provider/camera_image_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

class LocationService extends StateNotifier<DeviceLocation> {
  LocationService(this.ref) : super(const DeviceLocation());

  final AutoDisposeStateNotifierProviderRef<LocationService, DeviceLocation> ref;

  Future<void> getDeviceCurrentLocation() async {
    state = state.copyWith(isLoading: true, isLocationPermissionGranted: null, isLocationServiceEnabled: null);
    if (ref.read(cameraImageProvider.notifier).state == null) {
      print("Picture not added(Image is null)");
      state = state.copyWith(isLoading: false, locationText: "");
      return Future.error("Picture not added(Image is null)");
    }

    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    LocationData? locationData;

    try {
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          state = state.copyWith(
              isLoading: false,
              locationText: "",
              isLocationServiceEnabled: false);

          //imageProvider
          ref.read(cameraImageProvider.notifier).state = null;
          // return Future.error("Service is not enabled");
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          //if user denies access permission
          state = state.copyWith(
              isLoading: false,
              locationText: "",
              isLocationPermissionGranted: false);
          ref.read(cameraImageProvider.notifier).state = null;

          // return Future.error("Permission is not granted");
        }
      }

      locationData = await location.getLocation();

      state = state.copyWith(
          locationText: "${locationData.latitude}, ${locationData.longitude}",
          isLoading: false);

      print("Location: ${locationData.latitude}, ${locationData.longitude}");
    } catch (e) {
      state = state.copyWith(locationText: "", isLoading: false);
      print("determinePositionException: ${e.toString()}");
    }
  }
}
