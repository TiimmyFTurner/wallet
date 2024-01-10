import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';
import 'package:wallet/application/state_management/id_cards_provider.dart';
import 'package:wallet/domain/id_card_model.dart';

class EditIDCardScreen extends ConsumerStatefulWidget {
  final String cardId;

  const EditIDCardScreen(this.cardId,{super.key});

  @override
  EditIDCardScreenState createState() {
    return EditIDCardScreenState();
  }
}

class EditIDCardScreenState extends ConsumerState<EditIDCardScreen> {
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _expController = TextEditingController();
  final _fatherController = TextEditingController();
  final _serialController = TextEditingController();


  @override
  void initState() {
    IDCard card = ref
        .read(iDCardsProvider)
        .where((element) => element.id == widget.cardId)
        .first;
    _nameController.text = card.name;
    _selectedBackground = card.bgId;
    _numberController.text = card.number;
    _birthdayController.text = card.birthday;
    _expController.text = card.exp;
    _fatherController.text = card.father;
    _serialController.text = ((card.serial != '-') ? card.serial : '');
    super.initState();
  }
  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _birthdayController.dispose();
    _expController.dispose();
    _fatherController.dispose();
    _serialController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  String _selectedBackground = "1";
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
                  if (_serialController.text.isEmpty) {
                    setState(() {
                      _serialController.text = "-";
                    });
                  }
                  IDCard createdCard = IDCard(
                    id: widget.cardId,
                    bgId: _selectedBackground,
                    name: _nameController.text,
                    number: _numberController.text,
                    birthday: _birthdayController.text,
                    exp: _expController.text,
                    father: _fatherController.text,
                    serial: _serialController.text
                  );
                  ref
                      .read(iDCardsProvider.notifier)
                      .editIDCard(createdCard);
                  context.pop();
                }
              },
              child: Text(AppLocalizations.of(context)!.save)),
          const SizedBox(width: 16)
        ],
        title: Text(AppLocalizations.of(context)!.editIDCard),
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
                              image: AssetImage("assets/theme/cardbg$id.png"),
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
                            image: AssetImage("assets/theme/cardbg$item.png"),
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
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "${AppLocalizations.of(context)!.name}*",
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
                controller: _numberController,
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
                decoration: InputDecoration(
                  labelText: "${AppLocalizations.of(context)!.idNumber}*",
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.cantBeNull;
                  } else if (value.length < 10) {
                    return AppLocalizations.of(context)!.cantBeLessThan10;
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 36),
              child: TextFormField(
                controller: _fatherController,
                decoration: InputDecoration(
                  labelText: "${AppLocalizations.of(context)!.fatherName}*",
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
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: _birthdayController,
                      decoration: InputDecoration(
                        labelText:
                            "${AppLocalizations.of(context)!.birthDate}*",
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
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: _expController,
                      decoration: InputDecoration(
                        labelText: "${AppLocalizations.of(context)!.expDate}*",
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 36),
              child: TextFormField(
                controller: _serialController,
                inputFormatters: [LengthLimitingTextInputFormatter(26)],
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.serial,
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
}
