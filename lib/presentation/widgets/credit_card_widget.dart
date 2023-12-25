import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet/domain/credit_card_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreditCardWidget extends ConsumerWidget {
  final CreditCard creditCard;

  const CreditCardWidget(this.creditCard, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shadowColor: Colors.transparent,
      child: Stack(
        children: [
          Image(
            image: AssetImage('assets/bank_logos/${creditCard.bank.name}.png'),
            height: 75,
            opacity: const AlwaysStoppedAnimation(.35),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                fit: BoxFit.cover,
                opacity: .25,
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
                          onPressed: () => {copyBottomSheet(context)},
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
                            creditCard.number,
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
      ), // Foreground widget here
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
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: FilledButton.tonal(
                        onPressed: () => {
                          Clipboard.setData(
                              ClipboardData(text: creditCard.number)),
                          Navigator.pop(context),
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(AppLocalizations.of(context)!.cardNumberCopyMessage)),
                          )
                        },
                        child: Text(
                          AppLocalizations.of(context)!.copy,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: FilledButton.tonal(
                        onPressed: () => Navigator.pop(context),
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
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: FilledButton.tonal(
                        onPressed: () => {
                          Clipboard.setData(
                              ClipboardData(text: creditCard.shba!)),
                          Navigator.pop(context),
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(AppLocalizations.of(context)!.shbaCopyMessage)),
                          )
                        },
                        child: Text(
                          AppLocalizations.of(context)!.copy,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: FilledButton.tonal(
                        onPressed: () => Navigator.pop(context),
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
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.shba,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              creditCard.shba!,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                AppLocalizations.of(context)!.note,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                creditCard.note!,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                AppLocalizations.of(context)!.password,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                creditCard.pass!,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
