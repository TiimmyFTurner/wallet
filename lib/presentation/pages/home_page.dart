import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet/domain/credit_card_model.dart';
import 'package:wallet/infrastructure/data/bank_data.dart';
import 'package:wallet/presentation/widgets/credit_card_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final creditCard = CreditCard(
        title: "کارت مغازه",
        name: "ممد خیارزاده گوجه سان",
        number: "1234  1234  1234  1234",
        cvv2: "4354",
        exp: "08/01",
        bank: banks[6],
        note: "  شیسا بنتاش  شمنت اشس لیبتنشلس ت تشس لتلس شیتل شسیتبل سش تش لیتلشسیتبل تش ت اشسییتبلشست ل شسیل بتشسلا بت لای لای لالای یمنب شمک بانشتسیا بنتشسای منتشاسی ب",
        pass: "121212",
        shba: "IR062960000000100324200001");

    return Scaffold(
      body: CreditCardWidget(creditCard),
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.wallet)),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => {},
      ),
    );
    //throw UnimplementedError();
  }
}
