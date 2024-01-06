import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/application/state_management/credit_cards_provider.dart';
import 'package:wallet/application/state_management/note_cards_provider.dart';
import 'package:wallet/domain/credit_card_model.dart';
import 'package:wallet/domain/note_card_model.dart';
import 'package:wallet/presentation/widgets/credit_card_widget.dart';
import 'package:wallet/presentation/widgets/note_card_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<CreditCard> creditCards = ref.watch(creditCardsProvider);
    List<NoteCard> noteCards = ref.watch(noteCardsProvider);

    return Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.wallet)),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => {addItemBottomSheet(context)},
        ),
        bottomNavigationBar: NavigationBar(
          height: 70,
          onDestinationSelected: (int index) {
            setState(() => currentPageIndex = index);
          },
          selectedIndex: currentPageIndex,
          destinations: <Widget>[
            NavigationDestination(
              icon: const Icon(Icons.credit_card),
              label: AppLocalizations.of(context)!.creditCard,
            ),
            NavigationDestination(
              selectedIcon: const Icon(Icons.image),
              icon: const Icon(Icons.image_outlined),
              label: AppLocalizations.of(context)!.imageCard,
            ),
            NavigationDestination(
              selectedIcon: const Icon(Icons.note),
              icon: const Icon(Icons.note_outlined),
              label: AppLocalizations.of(context)!.noteCard,
            ),
          ],
        ),
        body: <Widget>[
          ListView.builder(
              padding: const EdgeInsets.only(bottom: 75),
              itemCount: creditCards.length,
              itemBuilder: (BuildContext context, int index) {
                return CreditCardWidget(creditCards[index]);
              }),
          ListView.builder(
              padding: const EdgeInsets.only(bottom: 75),
              itemCount: creditCards.length,
              itemBuilder: (BuildContext context, int index) {
                return CreditCardWidget(creditCards[index]);
              }),
          ListView.builder(
              padding: const EdgeInsets.only(bottom: 75),
              itemCount: noteCards.length,
              itemBuilder: (BuildContext context, int index) {
                return NoteCardWidget(noteCards[index]);
              }),
        ][currentPageIndex]);
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
                  onPressed: () {
                    context.pop();
                    context.go('/addNoteCard');
                  },
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
