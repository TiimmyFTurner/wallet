import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/application/state_management/password_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final String password = ref.watch(passwordProvider);
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   FilledButton(
        //       onPressed: () {
        //         if (_formKey.currentState!.validate()) {
        //           NoteCard createdCard = NoteCard(
        //             id: uuid.v1(),
        //             bgId: _selectedBackground,
        //             title: _titleController.text,
        //             note: _noteController.text,
        //           );
        //           ref.read(noteCardsProvider.notifier).addNoteCard(createdCard);
        //           context.pop();
        //         }
        //       },
        //       child: Text(AppLocalizations.of(context)!.save)),
        //   const SizedBox(width: 16)
        // ],
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: Center(
        child: Column(
          children: [
            FilledButton.tonal(
              onPressed: () => screenLock(
                context: context,
                title: Text(AppLocalizations.of(context)!.enterOldPassword),
                correctString: password,
                onCancelled: null,
                onUnlocked: () => screenLockCreate(
                    context: context,
                    title: Text(AppLocalizations.of(context)!.enterNewPassword),
                    cancelButton: Text(AppLocalizations.of(context)!.cancel),
                    confirmTitle:
                        Text(AppLocalizations.of(context)!.confirmNewPassword),
                    onConfirmed: (value) {
                      ref.read(passwordProvider.notifier).setPassword(value);
                      context.pop();
                      context.pop();
                    }),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .75,
                height: 70,
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.changePassword,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
