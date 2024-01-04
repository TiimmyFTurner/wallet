import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_card_model.freezed.dart';

@unfreezed
class ImageCard with _$ImageCard {
  factory ImageCard(String note, {required String title}) = _ImageCard;
}
