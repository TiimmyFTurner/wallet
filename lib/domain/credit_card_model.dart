import 'package:wallet/domain/bank_model.dart';

class CreditCard{
  final String title;
  final String name;
  final String number;
  final String cvv2;
  final String exp;
  final String? shba;
  final String? pass;
  final String? note;
  final Bank bank;

  final int id;

  CreditCard({
    required this.title,
    required this.id,
    required this.name,
    required this.number,
    required this.cvv2,
    required this.exp,
    this.shba,
    this.pass,
    this.note,
    required this.bank,
  });
}