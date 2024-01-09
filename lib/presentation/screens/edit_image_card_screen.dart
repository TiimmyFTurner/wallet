import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wallet/application/state_management/image_cards_provider.dart';
import 'package:wallet/domain/image_card_model.dart';

class EditImageCardScreen extends ConsumerStatefulWidget {
  final String cardId;

  const EditImageCardScreen(this.cardId, {super.key});

  @override
  EditImageCardScreenState createState() {
    return EditImageCardScreenState();
  }
}

class EditImageCardScreenState extends ConsumerState<EditImageCardScreen> {
  final _noteController = TextEditingController();
  late ImageCard card;

  @override
  void initState() {
    card = ref
        .read(imageCardsProvider)
        .where((element) => element.id == widget.cardId)
        .first;
    _noteController.text = ((card.note != '-') ? card.note : '');
    super.initState();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FilledButton(
              onPressed: () {
                if (_noteController.text.isEmpty) {
                  setState(() {
                    _noteController.text = "-";
                  });
                }
                ImageCard createdCard = ImageCard(
                  id: widget.cardId,
                  path: card.path,
                  note: _noteController.text,
                );
                ref
                    .read(imageCardsProvider.notifier)
                    .editImageCard(createdCard);
                context.pop();
              },
              child: Text(AppLocalizations.of(context)!.save)),
          const SizedBox(width: 16)
        ],
        title: Text(AppLocalizations.of(context)!.addImageCard),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 36),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                controller: _noteController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.note,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.cantBeNull;
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 8)
          ],
        ),
      ),
    );
  }
}
