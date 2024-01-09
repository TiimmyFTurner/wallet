import 'package:freezed_annotation/freezed_annotation.dart';

part 'id_card_model.freezed.dart';

part 'id_card_model.g.dart';

@unfreezed
class IDCard with _$IDCard {
  factory IDCard({
    required String id,
    required String bgId,
    required String number,
    required String name,
    required String birthday,
    required String father,
    required String exp,
    required String serial,
  }) = _IDCard;

  factory IDCard.fromJson(Map<String, dynamic> json) =>
      _$IDCardFromJson(json);
}
