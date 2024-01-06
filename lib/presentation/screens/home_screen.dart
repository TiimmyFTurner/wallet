import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/application/state_management/credit_cards_provider.dart';
import 'package:wallet/domain/credit_card_model.dart';
import 'package:wallet/infrastructure/data/bank_data.dart';
import 'package:wallet/presentation/widgets/credit_card_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var cards = ref.watch(creditCardsProvider);
    print(cards.length.toString());
    final creditCard = CreditCard(
        id: '0',
        title: "کارت مغازه",
        name: "ممد خیارزاده گوجه سان",
        number: "1234  1234  1234  1234",
        cvv2: "4354",
        exp: "08/01",
        bank: banks[6],
        note:
            "  شیسا بنتاش  شمنت اشس لیبتنشلس ت تشس لتلس شیتل شسیتبل سش تش لیتلشسیتبل تش ت اشسییتبلشست ل شسیل بتشسلا بت لای لای لالای یمنب شمک بانشتسیا بنتشسای منتشاسی ب",
        pass: "121212",
        shba: "IR062960000000100324200001");

    return Scaffold(
      body: ListView.builder(
          padding: const EdgeInsets.only(bottom: 75),
          itemCount: cards.length,
          itemBuilder: (BuildContext context, int index) {
            return CreditCardWidget(cards[index]);
          }),
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.wallet)),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => {addItemBottomSheet(context)},
      ),
    );
    //throw UnimplementedError();
  }

  addItemBottomSheet(context) {
    showModalBottomSheet<void>(
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(
              Icons.add_card_outlined,
              size: 36,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 12),
            Text(
              textAlign: TextAlign.center,
              AppLocalizations.of(context)!.addItem,
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: SizedBox(
                height: 56,
                child: FilledButton.tonal(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16), bottom: Radius.circular(4)),
                    ),
                  ),
                  onPressed: () {
                    context.pop();
                    context.go('/addCreditCard');
                  },
                  child: Text(
                    AppLocalizations.of(context)!.creditCard,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: SizedBox(
                height: 56,
                child: FilledButton.tonal(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                  ),
                  onPressed: () => {},
                  child: Text(
                    AppLocalizations.of(context)!.imageCard,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: SizedBox(
                height: 56,
                child: FilledButton.tonal(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(4), bottom: Radius.circular(16)),
                    ),
                  ),
                  onPressed: () => {},
                  child: Text(
                    AppLocalizations.of(context)!.noteCard,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24)
          ],
        );
      },
    );
  }
}
