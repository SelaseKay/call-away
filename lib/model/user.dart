import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';


@freezed
class UserModel with _$UserModel {

  const factory UserModel(
      {String? userId,
      required String username,
      required String email,
      required String password,
      @Default("")
      String profilePicUrl,
      @Default("")
      String phone,
      @Default("")
      String phoneVerifiedAt}) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
