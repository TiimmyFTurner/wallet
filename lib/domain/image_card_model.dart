import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_card_model.freezed.dart';

part 'image_card_model.g.dart';

@unfreezed
class ImageCard with _$ImageCard {
  factory ImageCard(String note, {required String title}) = _ImageCard;

  factory ImageCard.fromJson(Map<String, dynamic> json) =>
      _$ImageCardFromJson(json);
}
