import 'package:call_away/services/profile_update_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileUpdateStateProvider =
    StateNotifierProvider<ProfileUpdateService, ProfileUpdateState>((ref) {
  return ProfileUpdateService();
});
