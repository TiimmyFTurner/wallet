import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
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
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 8),
            FilledButton.tonal(
              onPressed: () => screenLock(
                context: context,
                title: Text(AppLocalizations.of(context)!.enterOldPassword),
                correctString: password,
                cancelButton: Text(AppLocalizations.of(context)!.cancel),
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppLocalizations.of(context)!
                              .passwordChangeMessage),
                        ),
                      );
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
            ),
            const SizedBox(height: 36),
            const Text("Mini Wallet 1.3.0",
                style: TextStyle(color: Colors.grey)),
            const Text("Copyright © 2024 Timothy F. Turner",
                style: TextStyle(color: Colors.grey)),
            InkWell(
              onTap: _sendMail,
              child: const Text("TiimmyFTurner@gmail.com",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey)),
            ),
            InkWell(
              onTap: _openTelegram,
              child: const Text("T.me/TiimmyFTurner",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendMail() async {
    final Uri url =
        Uri.parse('mailto:TiimmyFTurner@gmail.com?subject=MafiaApp');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _openTelegram() async {
    final Uri url = Uri.parse('https://T.me/TiimmyFTurner');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
