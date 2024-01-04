import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_model.freezed.dart';

part 'bank_model.g.dart';

@freezed
class Bank with _$Bank {
  const factory Bank({
    required String name,
    required String code,
  }) = _Bank;

  factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);
}
