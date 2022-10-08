import 'package:call_away/provider/camera_image_provider.dart';
import 'package:call_away/provider/video_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

abstract class DeviceLocationState {}

class DeviceLocationInitialState extends DeviceLocationState {}

class DeviceLocationLoadingState extends DeviceLocationState {}

class DeviceLocationErrorState extends DeviceLocationState {
  DeviceLocationErrorState(this.errorText);

  final String errorText;
}

class DeviceLocationSuccessState extends DeviceLocationState {
  DeviceLocationSuccessState(this.location);

  final String location;
}

class LocationService extends StateNotifier<DeviceLocationState> {
  LocationService(this.ref) : super(DeviceLocationInitialState());

  final AutoDisposeStateNotifierProviderRef<LocationService,
      DeviceLocationState> ref;

  Future<void> getDeviceCurrentLocation() async {
    state = DeviceLocationLoadingState();
    if (ref.read(videoProvider.notifier).state == null &&
        ref.read(cameraImageProvider.notifier).state == null) {
      print("Image or video not added(Image is null)");
      state = DeviceLocationErrorState("Image or video not added");
      return Future.error("Image or video not added(Image is null)");
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
          state = DeviceLocationErrorState("Location service is not enabled.");

          //imageProvider
          ref.read(cameraImageProvider.notifier).state = null;
          // return Future.error("Service is not enabled");
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          state =
              DeviceLocationErrorState("Location permission is not accepted");
          ref.read(cameraImageProvider.notifier).state = null;

          // return Future.error("Permission is not granted");
        }
      }

      locationData = await location.getLocation();

      state = DeviceLocationSuccessState(
          "${locationData.latitude}, ${locationData.longitude}");

      print("Location: ${locationData.latitude}, ${locationData.longitude}");
    } on PlatformException catch (e) {
      state = DeviceLocationErrorState(e.message!);
      print("determinePositionException: ${e.message!}");
    }
  }
}
