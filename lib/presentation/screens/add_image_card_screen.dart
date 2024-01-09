import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/application/state_management/image_cards_provider.dart';
import 'package:wallet/domain/image_card_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class AddImageCardScreen extends ConsumerStatefulWidget {
  const AddImageCardScreen({super.key});

  @override
  AddImageCardScreenState createState() {
    return AddImageCardScreenState();
  }
}

class AddImageCardScreenState extends ConsumerState<AddImageCardScreen> {
  var _image = null;
  final _noteController = TextEditingController();
  var uuid = const Uuid();

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
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (_noteController.text.isEmpty) {
                    setState(() {
                      _noteController.text = "-";
                    });
                  }
                  if (_image != null) {
                    context.pop();
                    final cardId = uuid.v1();
                    final directory = await getApplicationDocumentsDirectory();
                    final path = "${directory.path}/$cardId.jpg";
                    final imageFile = File(_image.path);
                    await imageFile.copy(path);
                    ImageCard createdCard = ImageCard(
                        id: cardId, note: _noteController.text, path: path);
                    ref
                        .read(imageCardsProvider.notifier)
                        .addImageCard(createdCard);
                  }
                }
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
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: SizedBox(
                  height: 75,
                  child: _image == null
                      ? FilledButton.tonal(
                          onPressed: () async {
                            await deleteBottomSheet(context, ref);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image_outlined),
                              SizedBox(width: 8),
                              Text(AppLocalizations.of(context)!.addImageCard,
                                  style: TextStyle(fontSize: 18)),
                            ],
                          ))
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 75,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  image: DecorationImage(
                                    image: FileImage(File(_image.path)),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            FilledButton.tonal(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .errorContainer),
                                onPressed: () {
                                  setState(() {
                                    imageCache.clear();
                                    _image = null;
                                  });
                                },
                                child: Text(AppLocalizations.of(context)!.deleteImage,))
                          ],
                        )),
            ),
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
              ),
            ),
            const SizedBox(height: 8)
          ],
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
              Icons.image_outlined,
              size: 36,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 12),
            Text(
              textAlign: TextAlign.center,
              AppLocalizations.of(context)!.addImageCard,
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
                  onPressed: () async {
                    context.pop();
                    _image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    setState(() {});
                  },
                  child: Text(
                    AppLocalizations.of(context)!.gallery,
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
                  onPressed: () async {
                    context.pop();
                    _image = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    setState(() {});
                  },
                  child: Text(
                    AppLocalizations.of(context)!.camera,
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
