// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NoteCard _$NoteCardFromJson(Map<String, dynamic> json) {
  return _NoteCard.fromJson(json);
}

/// @nodoc
mixin _$NoteCard {
  String get id => throw _privateConstructorUsedError;
  set id(String value) => throw _privateConstructorUsedError;
  String get bgId => throw _privateConstructorUsedError;
  set bgId(String value) => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  set title(String value) => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  set note(String value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NoteCardCopyWith<NoteCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteCardCopyWith<$Res> {
  factory $NoteCardCopyWith(NoteCard value, $Res Function(NoteCard) then) =
      _$NoteCardCopyWithImpl<$Res, NoteCard>;
  @useResult
  $Res call({String id, String bgId, String title, String note});
}

/// @nodoc
class _$NoteCardCopyWithImpl<$Res, $Val extends NoteCard>
    implements $NoteCardCopyWith<$Res> {
  _$NoteCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bgId = null,
    Object? title = null,
    Object? note = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      bgId: null == bgId
          ? _value.bgId
          : bgId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NoteCardImplCopyWith<$Res>
    implements $NoteCardCopyWith<$Res> {
  factory _$$NoteCardImplCopyWith(
          _$NoteCardImpl value, $Res Function(_$NoteCardImpl) then) =
      __$$NoteCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String bgId, String title, String note});
}

/// @nodoc
class __$$NoteCardImplCopyWithImpl<$Res>
    extends _$NoteCardCopyWithImpl<$Res, _$NoteCardImpl>
    implements _$$NoteCardImplCopyWith<$Res> {
  __$$NoteCardImplCopyWithImpl(
      _$NoteCardImpl _value, $Res Function(_$NoteCardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? bgId = null,
    Object? title = null,
    Object? note = null,
  }) {
    return _then(_$NoteCardImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      bgId: null == bgId
          ? _value.bgId
          : bgId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NoteCardImpl implements _NoteCard {
  _$NoteCardImpl(
      {required this.id,
      required this.bgId,
      required this.title,
      required this.note});

  factory _$NoteCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoteCardImplFromJson(json);

  @override
  String id;
  @override
  String bgId;
  @override
  String title;
  @override
  String note;

  @override
  String toString() {
    return 'NoteCard(id: $id, bgId: $bgId, title: $title, note: $note)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NoteCardImplCopyWith<_$NoteCardImpl> get copyWith =>
      __$$NoteCardImplCopyWithImpl<_$NoteCardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoteCardImplToJson(
      this,
    );
  }
}

abstract class _NoteCard implements NoteCard {
  factory _NoteCard(
      {required String id,
      required String bgId,
      required String title,
      required String note}) = _$NoteCardImpl;

  factory _NoteCard.fromJson(Map<String, dynamic> json) =
      _$NoteCardImpl.fromJson;

  @override
  String get id;
  set id(String value);
  @override
  String get bgId;
  set bgId(String value);
  @override
  String get title;
  set title(String value);
  @override
  String get note;
  set note(String value);
  @override
  @JsonKey(ignore: true)
  _$$NoteCardImplCopyWith<_$NoteCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
