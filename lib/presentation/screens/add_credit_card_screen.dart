import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/application/state_management/credit_cards_provider.dart';
import 'package:wallet/domain/bank_model.dart';
import 'package:wallet/domain/credit_card_model.dart';
import 'package:wallet/infrastructure/data/bank_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

class AddCreditCardScreen extends ConsumerStatefulWidget {
  const AddCreditCardScreen({super.key});

  @override
  AddCreditCardScreenState createState() {
    return AddCreditCardScreenState();
  }
}

class AddCreditCardScreenState extends ConsumerState<AddCreditCardScreen> {
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
  var uuid = const Uuid();

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
  Bank _selectedBank = banks[0];
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
                  if (_noteController.text.isEmpty) {
                    setState(() {
                      _noteController.text = "-";
                    });
                  }

                  if (_passController.text.isEmpty) {
                    setState(() {
                      _passController.text = "-";
                    });
                  }
                  if (_shbaController.text.isEmpty) {
                    setState(() {
                      _shbaController.text = "-";
                    });
                  }

                  CreditCard createdCard = CreditCard(
                    id: uuid.v1(),
                    bgId: _selectedBackground,
                    title: _titleController.text,
                    name: _nameController.text,
                    number: _numberController.text,
                    cvv2: _cvv2Controller.text,
                    exp:
                        "${_expMonthController.text}/${_expYearController.text}",
                    shba: _shbaController.text,
                    pass: _passController.text,
                    note: _noteController.text,
                    bank: _selectedBank,
                  );
                  ref
                      .read(creditCardsProvider.notifier)
                      .addCreditCard(createdCard);
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
                        width: MediaQuery.of(context).size.width * .75,
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
              child: DropdownButtonFormField<Bank>(
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: AppLocalizations.of(context)!.bank),
                value: _selectedBank, // Initial value
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
                    _selectedBank = newValue!;
                  });
                },
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
                controller: _nameController,
                textInputAction: TextInputAction.next,
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
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
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
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
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
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
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
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
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
                textInputAction: TextInputAction.next,
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
                controller: _passController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
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
