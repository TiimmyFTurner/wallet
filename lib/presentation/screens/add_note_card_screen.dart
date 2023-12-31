import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/application/state_management/credit_cards_provider.dart';
import 'package:wallet/application/state_management/note_cards_provider.dart';
import 'package:wallet/domain/bank_model.dart';
import 'package:wallet/domain/credit_card_model.dart';
import 'package:wallet/domain/note_card_model.dart';
import 'package:wallet/infrastructure/data/bank_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

class AddNoteCardScreen extends ConsumerStatefulWidget {
  const AddNoteCardScreen({super.key});

  @override
  AddNoteCardScreenState createState() {
    return AddNoteCardScreenState();
  }
}

class AddNoteCardScreenState extends ConsumerState<AddNoteCardScreen> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  var uuid = const Uuid();

  @override
  void dispose() {
    _titleController.dispose();
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
                if (_formKey.currentState!.validate()) {
                  NoteCard createdCard = NoteCard(
                    id: uuid.v1(),
                    title: _titleController.text,
                    note: _noteController.text,
                  );
                  ref.read(noteCardsProvider.notifier).addNoteCard(createdCard);
                  context.pop();
                }
              },
              child: Text(AppLocalizations.of(context)!.save)),
          const SizedBox(width: 16)
        ],
        title: Text(AppLocalizations.of(context)!.addNoteCard),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 36),
              child: TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "${AppLocalizations.of(context)!.title}*",
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 36),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                controller: _noteController,
                decoration: InputDecoration(
                  labelText: "${AppLocalizations.of(context)!.note}*",
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
