import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet/domain/bank_model.dart';

part 'credit_card_model.freezed.dart';

@unfreezed
class CreditCard with _$CreditCard {
  factory CreditCard({
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
}
