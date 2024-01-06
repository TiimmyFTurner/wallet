// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ImageCard _$ImageCardFromJson(Map<String, dynamic> json) {
  return _ImageCard.fromJson(json);
}

/// @nodoc
mixin _$ImageCard {
  String get note => throw _privateConstructorUsedError;
  set note(String value) => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  set id(String value) => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  set title(String value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImageCardCopyWith<ImageCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageCardCopyWith<$Res> {
  factory $ImageCardCopyWith(ImageCard value, $Res Function(ImageCard) then) =
      _$ImageCardCopyWithImpl<$Res, ImageCard>;
  @useResult
  $Res call({String note, String id, String title});
}

/// @nodoc
class _$ImageCardCopyWithImpl<$Res, $Val extends ImageCard>
    implements $ImageCardCopyWith<$Res> {
  _$ImageCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? note = null,
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImageCardImplCopyWith<$Res>
    implements $ImageCardCopyWith<$Res> {
  factory _$$ImageCardImplCopyWith(
          _$ImageCardImpl value, $Res Function(_$ImageCardImpl) then) =
      __$$ImageCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String note, String id, String title});
}

/// @nodoc
class __$$ImageCardImplCopyWithImpl<$Res>
    extends _$ImageCardCopyWithImpl<$Res, _$ImageCardImpl>
    implements _$$ImageCardImplCopyWith<$Res> {
  __$$ImageCardImplCopyWithImpl(
      _$ImageCardImpl _value, $Res Function(_$ImageCardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? note = null,
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_$ImageCardImpl(
      null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageCardImpl implements _ImageCard {
  _$ImageCardImpl(this.note, {required this.id, required this.title});

  factory _$ImageCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageCardImplFromJson(json);

  @override
  String note;
  @override
  String id;
  @override
  String title;

  @override
  String toString() {
    return 'ImageCard(note: $note, id: $id, title: $title)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageCardImplCopyWith<_$ImageCardImpl> get copyWith =>
      __$$ImageCardImplCopyWithImpl<_$ImageCardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageCardImplToJson(
      this,
    );
  }
}

abstract class _ImageCard implements ImageCard {
  factory _ImageCard(String note, {required String id, required String title}) =
      _$ImageCardImpl;

  factory _ImageCard.fromJson(Map<String, dynamic> json) =
      _$ImageCardImpl.fromJson;

  @override
  String get note;
  set note(String value);
  @override
  String get id;
  set id(String value);
  @override
  String get title;
  set title(String value);
  @override
  @JsonKey(ignore: true)
  _$$ImageCardImplCopyWith<_$ImageCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
