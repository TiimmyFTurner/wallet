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

/// @nodoc
mixin _$NoteCard {
  String get title => throw _privateConstructorUsedError;
  set title(String value) => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  set note(String value) => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NoteCardCopyWith<NoteCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteCardCopyWith<$Res> {
  factory $NoteCardCopyWith(NoteCard value, $Res Function(NoteCard) then) =
      _$NoteCardCopyWithImpl<$Res, NoteCard>;
  @useResult
  $Res call({String title, String note});
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
    Object? title = null,
    Object? note = null,
  }) {
    return _then(_value.copyWith(
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
  $Res call({String title, String note});
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
    Object? title = null,
    Object? note = null,
  }) {
    return _then(_$NoteCardImpl(
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

class _$NoteCardImpl implements _NoteCard {
  _$NoteCardImpl({required this.title, required this.note});

  @override
  String title;
  @override
  String note;

  @override
  String toString() {
    return 'NoteCard(title: $title, note: $note)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NoteCardImplCopyWith<_$NoteCardImpl> get copyWith =>
      __$$NoteCardImplCopyWithImpl<_$NoteCardImpl>(this, _$identity);
}

abstract class _NoteCard implements NoteCard {
  factory _NoteCard({required String title, required String note}) =
      _$NoteCardImpl;

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