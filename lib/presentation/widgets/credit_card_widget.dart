import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/application/state_management/credit_cards_provider.dart';
import 'package:wallet/domain/credit_card_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';

class CreditCardWidget extends ConsumerWidget {
  final CreditCard creditCard;

  const CreditCardWidget(this.creditCard, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String number = creditCard.number;
    String showNumber =
        "${number.substring(0, 4)}  ${number.substring(4, 8)}  ${number.substring(8, 12)}  ${number.substring(12, 16)}";
    return GestureDetector(
      onLongPress: () {
        HapticFeedback.lightImpact();
        longPressBottomSheet(context, ref);
      },
      child: Card(
        shadowColor: Colors.transparent,
        child: Stack(
          children: [
            Image(
              image:
                  AssetImage('assets/bank_logos/${creditCard.bank.name}.png'),
              height: 75,
              opacity: const AlwaysStoppedAnimation(.55),
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  opacity: .15,
                  image: AssetImage('assets/theme/cardbg.png'),
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
                            creditCard.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                            onPressed: () => copyBottomSheet(context),
                            icon: const Icon(Icons.share)),
                      ],
                    ),
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '   ${creditCard.name}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    moreCardDetailBottomSheet(context);
                                  },
                                  icon: const Icon(Icons.note)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              textDirection: TextDirection.ltr,
                              showNumber,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '${AppLocalizations.of(context)!.expDate}: ${creditCard.exp}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                'CVV2: ${creditCard.cvv2}',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  copyBottomSheet(context) {
    showModalBottomSheet<void>(
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                AppLocalizations.of(context)!.share,
                style: const TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
              child: Text(
                AppLocalizations.of(context)!.cardNumber,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: FilledButton.tonal(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(16),
                                left: Radius.circular(4)),
                          ),
                        ),
                        onPressed: () => {
                          Clipboard.setData(
                              ClipboardData(text: creditCard.number)),
                          Navigator.pop(context),
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalizations.of(context)!
                                  .cardNumberCopyMessage),
                            ),
                          )
                        },
                        child: Text(
                          AppLocalizations.of(context)!.copy,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: FilledButton.tonal(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(16),
                                right: Radius.circular(4)),
                          ),
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                          await Share.share(creditCard.number);
                        },
                        child: Text(AppLocalizations.of(context)!.share,
                            style: const TextStyle(fontSize: 20)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
              child: Text(
                AppLocalizations.of(context)!.shba,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: FilledButton.tonal(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(4),
                                right: Radius.circular(16)),
                          ),
                        ),
                        onPressed: () => {
                          Clipboard.setData(
                              ClipboardData(text: creditCard.shba)),
                          Navigator.pop(context),
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalizations.of(context)!
                                  .shbaCopyMessage),
                            ),
                          )
                        },
                        child: Text(
                          AppLocalizations.of(context)!.copy,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: FilledButton.tonal(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(16),
                                right: Radius.circular(4)),
                          ),
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                          await Share.share(creditCard.shba);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.share,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24)
          ],
        );
      },
    );
  }

  moreCardDetailBottomSheet(context) {
    return showModalBottomSheet<void>(
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.shba,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    creditCard.shba,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.note,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SizedBox(
                    height: 150,
                    child: SingleChildScrollView(
                      child: Text(
                        creditCard.note,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.password,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    creditCard.pass,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  longPressBottomSheet(context, ref) {
    showModalBottomSheet<void>(
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: SizedBox(
                height: 60,
                child: FilledButton.tonal(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16), bottom: Radius.circular(4)),
                    ),
                  ),
                  onPressed: () {
                    context.pop();
                    context.go('/editCreditCard/${creditCard.id}');
                  },
                  child: Text(
                    AppLocalizations.of(context)!.edit,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: SizedBox(
                height: 60,
                child: FilledButton.tonal(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.errorContainer,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(4),
                            bottom: Radius.circular(16)),
                      )),
                  onPressed: () {
                    context.pop();
                    deleteBottomSheet(context,ref);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.delete,
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
              AppLocalizations.of(context)!.deleteCreditCardQuestion,
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
                        .read(creditCardsProvider.notifier)
                        .removeCreditCard(creditCard.id);
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
