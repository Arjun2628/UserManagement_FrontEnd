import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
	@JsonKey(name: '_id') 
	String? id;
	String? name;
	int? age;
	String? email;
	String? profileImage;
	@JsonKey(name: '__v') 
	int? v;

	UserModel({
		this.id, 
		this.name, 
		this.age, 
		this.email, 
		this.profileImage, 
		this.v, 
	});

	factory UserModel.fromJson(Map<String, dynamic> json) {
		return _$UserModelFromJson(json);
	}

	Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
