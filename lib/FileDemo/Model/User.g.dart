// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['name'] as String,
    json['sex'] as String,
    json['age'] as int,
    (json['fan'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'sex': instance.sex,
      'age': instance.age,
      'fan': instance.fan,
    };
