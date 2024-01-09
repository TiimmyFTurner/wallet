import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/application/state_management/note_cards_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet/domain/note_card_model.dart';

class NoteCardWidget extends ConsumerWidget {
  final NoteCard noteCard;

  const NoteCardWidget(this.noteCard, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      child: Card(
        shadowColor: Colors.transparent,
        child: Container(
          decoration:  BoxDecoration(
            borderRadius:const BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
              fit: BoxFit.cover,
              opacity: .35,
              image: AssetImage('assets/theme/cardbg${noteCard.bgId}.png'),
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              shadowColor: Colors.transparent,
              splashColor: Colors.transparent,
              dividerColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ExpansionTile(
                onExpansionChanged: (bool expanding) {
                  HapticFeedback.lightImpact();
                },
                title: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        noteCard.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          context.go('/editNoteCard/${noteCard.id}');
                        },
                        icon: const Icon(Icons.edit)),
                    IconButton(
                        onPressed: () => deleteBottomSheet(context, ref),
                        icon: const Icon(Icons.delete)),
                  ],
                ),
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 225,
                    alignment: AlignmentDirectional.topStart,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical, //.horizontal
                      child: Text(
                        textAlign: TextAlign.justify,
                        noteCard.note,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  deleteBottomSheet(context, ref) {
    showModalBottomSheet<void>(
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(
              Icons.delete_outline,
              size: 36,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 12),
            Text(
              textAlign: TextAlign.center,
              AppLocalizations.of(context)!.deleteNoteCardQuestion,
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: SizedBox(
                height: 56,
                child: FilledButton.tonal(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.errorContainer,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16), bottom: Radius.circular(4)),
                    ),
                  ),
                  onPressed: () {
                    context.pop();
                    ref
                        .read(noteCardsProvider.notifier)
                        .removeNoteCard(noteCard.id);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.delete,
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
                  },
                  child: Text(
                    AppLocalizations.of(context)!.no,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 36)
          ],
        );
      },
    );
  }
}
