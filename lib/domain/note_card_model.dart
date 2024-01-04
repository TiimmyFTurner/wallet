import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_card_model.freezed.dart';

part 'note_card_model.g.dart';

@unfreezed
class NoteCard with _$NoteCard {
  factory NoteCard(
      {required int id,
      required String title,
      required String note}) = _NoteCard;

  factory NoteCard.fromJson(Map<String, dynamic> json) =>
      _$NoteCardFromJson(json);
}
