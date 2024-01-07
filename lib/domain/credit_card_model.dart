import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet/domain/bank_model.dart';

part 'credit_card_model.freezed.dart';

part 'credit_card_model.g.dart';

@unfreezed
class CreditCard with _$CreditCard {
  factory CreditCard({
    required String id,
    required String bgId,
    required String title,
    required String name,
    required String number,
    required String cvv2,
    required String exp,
    required String shba,
    required String pass,
    required String note,
    required Bank bank,
  }) = _CreditCard;

  factory CreditCard.fromJson(Map<String, dynamic> json) =>
      _$CreditCardFromJson(json);
}
