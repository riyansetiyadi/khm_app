import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel {
  String? token;

  UserModel({this.token});

  factory UserModel.fromJson(json) => _$UserModelFromJson(json);

  toJson() => _$UserModelToJson(this);

  static List<UserModel> fromJsonList(List? json) {
    return json?.map((e) => UserModel.fromJson(e)).toList() ?? [];
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    if (other is UserModel) {
      // return other.id == id;
    }

    return false;
  }
}
