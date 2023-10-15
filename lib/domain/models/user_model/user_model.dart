import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
	@JsonKey(name: '_id') 
	String? id;
	String? name;
	@JsonKey(name: '__v') 
	int? v;

	UserModel({this.id, this.name, this.v});

	factory UserModel.fromJson(Map<String, dynamic> json) {
		return _$UserModelFromJson(json);
	}

	Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
