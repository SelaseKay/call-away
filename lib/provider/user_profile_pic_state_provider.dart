import 'package:call_away/services/user_pic_update_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProfilPicStateProvider =
    StateNotifierProvider<UserPictureUpdateService, UserProfilePictureState>(
        (ref) {
  return UserPictureUpdateService(ref);
});
