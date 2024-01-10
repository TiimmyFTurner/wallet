import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/application/state_management/id_cards_provider.dart';
import 'package:wallet/domain/id_card_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IDCardWidget extends ConsumerWidget {
  final IDCard idCard;

  const IDCardWidget(this.idCard, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shadowColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
            fit: BoxFit.cover,
            opacity: .35,
            image: AssetImage('assets/theme/cardbg${idCard.bgId}.png'),
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
                      AppLocalizations.of(context)!.idCard,
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
                        context.go('/editIDCard/${idCard.id}');
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () => deleteBottomSheet(context, ref),
                      icon: const Icon(Icons.delete)),
                ],
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.name}: ",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            idCard.name,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.idNumber}: ",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            idCard.number,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.fatherName}: ",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            idCard.father,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${AppLocalizations.of(context)!.birthDate}: ${idCard.birthday}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            '${AppLocalizations.of(context)!.expDate}: ${idCard.exp}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.serial}: ",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            idCard.serial,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                )
              ],
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
              AppLocalizations.of(context)!.deleteIDCardQuestion,
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
                    ref.read(iDCardsProvider.notifier).removeIDCard(idCard.id);
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
