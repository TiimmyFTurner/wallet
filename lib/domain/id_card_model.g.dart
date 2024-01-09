// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'id_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IDCardImpl _$$IDCardImplFromJson(Map<String, dynamic> json) => _$IDCardImpl(
      id: json['id'] as String,
      bgId: json['bgId'] as String,
      number: json['number'] as String,
      name: json['name'] as String,
      birthday: json['birthday'] as String,
      father: json['father'] as String,
      exp: json['exp'] as String,
      serial: json['serial'] as String,
    );

Map<String, dynamic> _$$IDCardImplToJson(_$IDCardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bgId': instance.bgId,
      'number': instance.number,
      'name': instance.name,
      'birthday': instance.birthday,
      'father': instance.father,
      'exp': instance.exp,
      'serial': instance.serial,
    };
