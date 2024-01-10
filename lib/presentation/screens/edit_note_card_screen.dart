import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/application/state_management/note_cards_provider.dart';
import 'package:wallet/domain/note_card_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditNoteCardScreen extends ConsumerStatefulWidget {
  final String cardId;

  const EditNoteCardScreen(this.cardId, {super.key});

  @override
  EditNoteCardScreenState createState() {
    return EditNoteCardScreenState();
  }
}

class EditNoteCardScreenState extends ConsumerState<EditNoteCardScreen> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  late String _selectedBackground;

  @override
  void initState() {
    NoteCard card = ref
        .read(noteCardsProvider)
        .where((element) => element.id == widget.cardId)
        .first;
    _selectedBackground = card.bgId;
    _titleController.text = card.title;
    _noteController.text = card.note;

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final _backgroundList = List<String>.generate(10, (i) {
    return (i + 1).toString();
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  NoteCard createdCard = NoteCard(
                    id: widget.cardId,
                    bgId: _selectedBackground,
                    title: _titleController.text,
                    note: _noteController.text,
                  );
                  ref
                      .read(noteCardsProvider.notifier)
                      .editNoteCard(createdCard);
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
              child: IntrinsicWidth(
                child: DropdownButtonFormField<String>(
                  icon: const SizedBox(),
                  iconSize: 75,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.background),
                  value: _selectedBackground,
                  items: _backgroundList
                      .map<DropdownMenuItem<String>>((String id) {
                    return DropdownMenuItem<String>(
                      value: id,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 75,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/theme/cardbg${id}.png"),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  selectedItemBuilder: (_) {
                    return _backgroundList.map<Widget>((String item) {
                      return Container(
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/theme/cardbg${item}.png"),
                          ),
                        ),
                      );
                    }).toList();
                  },
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedBackground = newValue!;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 36),
              child: TextFormField(
                controller: _titleController,
                textInputAction: TextInputAction.next,
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
