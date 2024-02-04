import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/application/state_management/credit_cards_provider.dart';
import 'package:wallet/application/state_management/id_cards_provider.dart';
import 'package:wallet/application/state_management/image_cards_provider.dart';
import 'package:wallet/application/state_management/note_cards_provider.dart';
import 'package:wallet/domain/credit_card_model.dart';
import 'package:wallet/domain/id_card_model.dart';
import 'package:wallet/domain/image_card_model.dart';
import 'package:wallet/domain/note_card_model.dart';
import 'package:wallet/presentation/widgets/credit_card_widget.dart';
import 'package:wallet/presentation/widgets/id_card_widget.dart';
import 'package:wallet/presentation/widgets/note_card_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _pageViewController = PageController();
  int currentPageIndex = 0;
  bool idCardExist = false;


  @override
  Widget build(BuildContext context) {
    List<CreditCard> creditCards = ref.watch(creditCardsProvider);
    List<NoteCard> noteCards = ref.watch(noteCardsProvider);
    List<ImageCard> imageCards = ref.watch(imageCardsProvider);
    List<IDCard> idCards = ref.watch(iDCardsProvider);
    idCardExist = idCards.isEmpty ? false : true;
    emptyStateWidget() {
      return Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Image.asset('assets/theme/empty.png'),
            ),
            Opacity(
              opacity: .75,
              child: Text(
                AppLocalizations.of(context)!.emptyPocketMessage,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      );
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
                      context.push('/addCreditCard');
                    },
                    child: Text(
                      AppLocalizations.of(context)!.creditCard,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              idCardExist
                  ? const SizedBox(height: 6)
                  : Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 36, vertical: 6),
                child: SizedBox(
                  height: 56,
                  child: FilledButton.tonal(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(4))),
                    ),
                    onPressed: () {
                      context.pop();
                      context.push('/addIDCard');
                    },
                    child: Text(
                      AppLocalizations.of(context)!.idCard,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: SizedBox(
                  height: 56,
                  child: FilledButton.tonal(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                    ),
                    onPressed: () {
                      context.pop();
                      context.push('/addImageCard');
                    },
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
                      context.push('/addNoteCard');
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
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.wallet),
          actions: [
            IconButton(
                onPressed: () {
                  context.pushNamed('settings');
                },
                icon: const Icon(Icons.settings)),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Hero(
                  tag: "search",
                  child: IconButton(
                      onPressed: () {
                        context.push('/searchScreen');
                      },
                      icon: const Icon(Icons.search)),
                )),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => {addItemBottomSheet(context)},
        ),
        bottomNavigationBar: NavigationBar(
          height: 70,
          onDestinationSelected: (int index) {
            _pageViewController.animateToPage(index,
                duration: const Duration(milliseconds: 250),
                curve: Curves.decelerate);
            },
          selectedIndex: currentPageIndex,
          destinations: <Widget>[
            NavigationDestination(
              icon: const Icon(Icons.credit_card),
              label: AppLocalizations.of(context)!.creditCard,
            ),
            NavigationDestination(
              selectedIcon: const Icon(Icons.person),
              icon: const Icon(Icons.perm_identity),
              label: AppLocalizations.of(context)!.identifications,
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
        body: PageView(
          controller: _pageViewController,
          onPageChanged: (index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          children: <Widget>[
            creditCards.isEmpty
                ? emptyStateWidget()
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 75),
                    itemCount: creditCards.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CreditCardWidget(creditCards[index]);
                    }),
            idCards.isEmpty
                ? emptyStateWidget()
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 75),
                    itemCount: idCards.length,
                    itemBuilder: (BuildContext context, int index) {
                      return IDCardWidget(idCards[index]);
                    }),
            imageCards.isEmpty
                ? emptyStateWidget()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: imageCards.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context
                                .push('/showImageCard/${imageCards[index].id}');
                          },
                          child: Hero(
                            tag: "img${imageCards[index].id}",
                            child: Container(
                              width: 75,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  image:
                                      FileImage(File(imageCards[index].path)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            noteCards.isEmpty
                ? emptyStateWidget()
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 75),
                    itemCount: noteCards.length,
                    itemBuilder: (BuildContext context, int index) {
                      return NoteCardWidget(noteCards[index]);
                    }),
          ],
          // [currentPageIndex],
        ));
  }


}
