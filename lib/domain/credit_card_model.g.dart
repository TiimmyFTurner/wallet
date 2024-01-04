// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreditCardImpl _$$CreditCardImplFromJson(Map<String, dynamic> json) =>
    _$CreditCardImpl(
      id: json['id'] as int,
      title: json['title'] as String,
      name: json['name'] as String,
      number: json['number'] as String,
      cvv2: json['cvv2'] as String,
      exp: json['exp'] as String,
      shba: json['shba'] as String,
      pass: json['pass'] as String,
      note: json['note'] as String,
      bank: Bank.fromJson(json['bank'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CreditCardImplToJson(_$CreditCardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'name': instance.name,
      'number': instance.number,
      'cvv2': instance.cvv2,
      'exp': instance.exp,
      'shba': instance.shba,
      'pass': instance.pass,
      'note': instance.note,
      'bank': instance.bank,
    };
