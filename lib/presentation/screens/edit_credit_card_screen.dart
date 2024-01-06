import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/application/state_management/credit_cards_provider.dart';
import 'package:wallet/domain/bank_model.dart';
import 'package:wallet/domain/credit_card_model.dart';
import 'package:wallet/infrastructure/data/bank_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditCreditCardScreen extends ConsumerStatefulWidget {
  final String cardId;

  const EditCreditCardScreen(this.cardId,{super.key});

  @override
  EditCreditCardScreenState createState() {
    return EditCreditCardScreenState();
  }
}

class EditCreditCardScreenState extends ConsumerState<EditCreditCardScreen> {
  final _titleController = TextEditingController();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _cvv2Controller = TextEditingController();
  final _expMonthController = TextEditingController();
  final _expYearController = TextEditingController();
  final _shbaController = TextEditingController();
  final _passController = TextEditingController();
  final _noteController = TextEditingController();
  bool _passwordVisible = false;
  late Bank selectedBank;

  @override
  void initState() {
    CreditCard card = ref
        .read(creditCardsProvider)
        .where((element) => element.id == widget.cardId)
        .first;
     selectedBank = card.bank;
    _titleController.text = card.title;
    _nameController.text = card.name;
    _numberController.text = card.number;
    _cvv2Controller.text = card.cvv2;
    final expDate = card.exp.split('/');
    _expMonthController.text = expDate[0];
    _expYearController.text = expDate[1];
    _shbaController.text = ((card.shba != '-') ? card.shba:'');
    _passController.text = ((card.pass != '-') ? card.pass:'');
    _noteController.text = ((card.note != '-') ? card.note:'');
    super.initState();
  }
  @override
  void dispose() {
    _titleController.dispose();
    _nameController.dispose();
    _numberController.dispose();
    _cvv2Controller.dispose();
    _expMonthController.dispose();
    _expYearController.dispose();
    _shbaController.dispose();
    _passController.dispose();
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
                  if (_noteController.text.isEmpty) {
                    setState(() {
                      _noteController.text = "-";
                    });
                    if (_passController.text.isEmpty) {
                      setState(() {
                        _passController.text = "-";
                      });
                      if (_shbaController.text.isEmpty) {
                        setState(() {
                          _shbaController.text = "-";
                        });
                      }
                    }
                  }
                  CreditCard createdCard = CreditCard(
                    id: widget.cardId,
                    title: _titleController.text,
                    name: _nameController.text,
                    number: _numberController.text,
                    cvv2: _cvv2Controller.text,
                    exp:
                    "${_expMonthController.text}/${_expYearController.text}",
                    shba: _shbaController.text,
                    pass: _passController.text,
                    note: _noteController.text,
                    bank: selectedBank,
                  );
                  print(createdCard);

                  ref
                      .read(creditCardsProvider.notifier)
                      .editCreditCard(createdCard);
                  context.pop();
                }
              },
              child: Text(AppLocalizations.of(context)!.save)),
          const SizedBox(width: 16)
        ],
        title: Text(AppLocalizations.of(context)!.addCreditCard),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 36),
              child: DropdownButtonFormField<Bank>(
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: AppLocalizations.of(context)!.bank),
                value: selectedBank, // Initial value
                items: banks.map<DropdownMenuItem<Bank>>((Bank bank) {
                  return DropdownMenuItem<Bank>(
                    value: bank,
                    child: Text(
                      AppLocalizations.of(context)!.bankName(bank.name),
                    ),
                  );
                }).toList(),
                onChanged: (Bank? newValue) {
                  setState(() {
                    selectedBank = newValue!;
                  });
                },
              ),
            ),
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
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "${AppLocalizations.of(context)!.name}*",
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.cantBeNull;
                  } else if (value.length < 3) {
                    return AppLocalizations.of(context)!.cantBeLessThan3;
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 36),
              child: TextFormField(
                controller: _numberController,
                inputFormatters: [LengthLimitingTextInputFormatter(16)],
                decoration: InputDecoration(
                  labelText: "${AppLocalizations.of(context)!.cardNumber}*",
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.cantBeNull;
                  } else if (value.length != 16) {
                    return AppLocalizations.of(context)!.mustBe16;
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
                    flex: 2,
                    child: TextFormField(
                      controller: _cvv2Controller,
                      inputFormatters: [LengthLimitingTextInputFormatter(5)],
                      decoration: const InputDecoration(
                        labelText: "CVV2*",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.cantBeNull;
                        } else if (value.length < 3) {
                          return AppLocalizations.of(context)!.cantBeLessThan3;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: _expMonthController,
                      inputFormatters: [LengthLimitingTextInputFormatter(2)],
                      decoration: InputDecoration(
                        labelText: "${AppLocalizations.of(context)!.month}*",
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.cantBeNull;
                        } else if (value.length == 1) {
                          _expMonthController.text =
                          "0${_expMonthController.text}";
                        }
                        return null;
                      },
                    ),
                  ),
                  const Opacity(
                      opacity: .4,
                      child: Text(" / ", style: TextStyle(fontSize: 24))),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: _expYearController,
                      inputFormatters: [LengthLimitingTextInputFormatter(2)],
                      decoration: InputDecoration(
                        labelText: "${AppLocalizations.of(context)!.year}*",
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.cantBeNull;
                        } else if (value.length == 1) {
                          _expYearController.text =
                          "0${_expYearController.text}";
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
                controller: _shbaController,
                inputFormatters: [LengthLimitingTextInputFormatter(26)],
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.shba,
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 36),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: _passController,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: AppLocalizations.of(context)!.password,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 36),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 4,
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
}
