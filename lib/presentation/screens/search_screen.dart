import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/application/state_management/credit_cards_provider.dart';
import 'package:wallet/application/state_management/image_cards_provider.dart';
import 'package:wallet/application/state_management/note_cards_provider.dart';
import 'package:wallet/domain/credit_card_model.dart';
import 'package:wallet/domain/image_card_model.dart';
import 'package:wallet/domain/note_card_model.dart';
import 'package:wallet/presentation/widgets/credit_card_widget.dart';
import 'package:wallet/presentation/widgets/note_card_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  SearchController controller = SearchController();
  late List<CreditCard> creditCards;
  late List<NoteCard> noteCards;
  late List<ImageCard> imageCards;
  late List<CreditCard> searchedCreditCards;
  late List<NoteCard> searchedNoteCards;
  late List<ImageCard> searchedImageCards;
  bool nothingFound = true;

  @override
  void initState() {
    creditCards = ref.read(creditCardsProvider);
    noteCards = ref.read(noteCardsProvider);
    imageCards = ref.read(imageCardsProvider);
    nothingFound =
        creditCards.isEmpty && noteCards.isEmpty && imageCards.isEmpty;
    searchedCreditCards = creditCards;
    searchedNoteCards = noteCards;
    searchedImageCards = imageCards;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBar(
                controller: controller,
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
                onTap: () {},
                onChanged: (_) {
                  setState(() {
                    if (controller.text.isNotEmpty) {
                      searchedCreditCards = creditCards
                          .where((element) =>
                              element.name.contains(controller.text) ||
                              element.title.contains(controller.text))
                          .toList();
                      searchedNoteCards = noteCards
                          .where((element) =>
                              element.title.contains(controller.text) ||
                              element.note.contains(controller.text))
                          .toList();
                      searchedImageCards = imageCards
                          .where((element) =>
                              element.note.contains(controller.text))
                          .toList();
                    } else {
                      searchedCreditCards = creditCards;
                      searchedNoteCards = noteCards;
                      searchedImageCards = imageCards;
                    }
                    nothingFound = searchedCreditCards.isEmpty &&
                        searchedNoteCards.isEmpty &&
                        searchedImageCards.isEmpty;
                  });
                },
                leading:
                    const Hero(tag: "searchIcon", child: Icon(Icons.search)),
              ),
            ),
            nothingFound
                ? emptyStateWidget()
                : Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 75),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            searchedCreditCards.isEmpty
                                ? const SizedBox()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .creditCard,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: searchedCreditCards.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return CreditCardWidget(
                                                searchedCreditCards[index]);
                                          }),
                                    ],
                                  ),
                            searchedNoteCards.isEmpty
                                ? const SizedBox()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .noteCard,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: searchedNoteCards.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return NoteCardWidget(
                                                searchedNoteCards[index]);
                                          }),
                                    ],
                                  ),
                            searchedImageCards.isEmpty
                                ? const SizedBox()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .imageCard,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 8,
                                        ),
                                        itemCount: searchedImageCards.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              context.push(
                                                  '/showImageCard/${searchedImageCards[index].id}');
                                            },
                                            child: Hero(
                                              tag:
                                                  "img${searchedImageCards[index].id}",
                                              child: Container(
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                  image: DecorationImage(
                                                    image: FileImage(File(
                                                        searchedImageCards[
                                                                index]
                                                            .path)),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  emptyStateWidget() {
    return Center(
      child: Column(
        children: [
          Image.asset('assets/theme/empty.png'),
          Opacity(
            opacity: .75,
            child: Text(
              AppLocalizations.of(context)!.emptySearchResultMessage,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
