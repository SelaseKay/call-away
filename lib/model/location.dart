class DeviceLocation {
  const DeviceLocation(
      {this.locationText = "",
      this.isLoading = false,
      this.isLocationPermissionGranted,
      this.isLocationServiceEnabled});

  final String locationText;
  final bool isLoading;
  final bool? isLocationPermissionGranted;
  final bool? isLocationServiceEnabled;

  DeviceLocation copyWith(
      {String? locationText,
      bool? isLoading,
      bool? isLocationPermissionGranted,
      bool? isLocationServiceEnabled}) {
    return DeviceLocation(
      locationText: locationText ?? this.locationText,
      isLoading: isLoading ?? this.isLoading,
      isLocationPermissionGranted: isLocationPermissionGranted ?? this.isLocationPermissionGranted,
      isLocationServiceEnabled: isLocationServiceEnabled ?? this.isLocationServiceEnabled
    );
  }
}
