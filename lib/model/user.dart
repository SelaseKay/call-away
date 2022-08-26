import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

// @JsonSerializable()
@freezed
class UserModel with _$UserModel {
  // String? userId;
  // String username;
  // String email;
  // String password;
  // String phone;
  // String phoneVerifiedAt;

  const factory UserModel(
      {String? userId,
      required String username ,
      required String email,
      required String password,
      @Default("")
      String phone,
      @Default("")
      String phoneVerifiedAt}) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
