// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NoteCardImpl _$$NoteCardImplFromJson(Map<String, dynamic> json) =>
    _$NoteCardImpl(
      id: json['id'] as String,
      bgId: json['bgId'] as String,
      title: json['title'] as String,
      note: json['note'] as String,
    );

Map<String, dynamic> _$$NoteCardImplToJson(_$NoteCardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bgId': instance.bgId,
      'title': instance.title,
      'note': instance.note,
    };
