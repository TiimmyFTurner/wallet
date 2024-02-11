import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallet/application/state_management/backup_provider.dart';
import 'package:wallet/application/state_management/credit_cards_provider.dart';
import 'package:wallet/application/state_management/password_provider.dart';
import 'package:wallet/application/state_management/settings_provider.dart';
import 'package:wallet/l10n/l10n.dart';
import 'package:file_picker/file_picker.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final String password = ref.watch(passwordProvider);
    bool passwordStatus = ref.watch(passwordStatusProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          SwitchListTile(
              title: Text(AppLocalizations.of(context)!.usePassword),
              value: passwordStatus,
              onChanged: (value) {
                ref.read(passwordStatusProvider.notifier).toggle();
                if (!passwordStatus && password.isEmpty) {
                  screenLockCreate(
                      onCancelled: () {
                        ref.read(passwordStatusProvider.notifier).toggle();
                        context.pop();
                      },
                      context: context,
                      title: Text(AppLocalizations.of(context)!.enterPassword),
                      cancelButton: Text(AppLocalizations.of(context)!.cancel),
                      confirmTitle:
                          Text(AppLocalizations.of(context)!.confirmPassword),
                      onConfirmed: (value) {
                        ref.read(passwordProvider.notifier).setPassword(value);
                        context.pop();
                      });
                }
              }),
          ListTile(
            enabled: passwordStatus,
            title: Text(AppLocalizations.of(context)!.changePassword),
            onTap: () => screenLock(
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
          ),
          const Divider(),
          ListTile(
              title: Text(AppLocalizations.of(context)!.chooseTheme),
              subtitle: Text(AppLocalizations.of(context)!
                  .themeMode(ref.watch(themeModeSettingProvider).name)),
              onTap: () {
                ThemeMode themeMode = ref.read(themeModeSettingProvider);
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) =>
                      StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      title: Text(AppLocalizations.of(context)!.chooseTheme),
                      content:
                          Column(mainAxisSize: MainAxisSize.min, children: [
                        RadioListTile<ThemeMode>(
                          title: Text(
                              AppLocalizations.of(context)!.themeMode('light')),
                          value: ThemeMode.light,
                          groupValue: themeMode,
                          onChanged: (value) {
                            setState(() {
                              themeMode = value!;
                            });
                          },
                        ),
                        RadioListTile<ThemeMode>(
                          title: Text(
                              AppLocalizations.of(context)!.themeMode('dark')),
                          value: ThemeMode.dark,
                          groupValue: themeMode,
                          onChanged: (value) {
                            setState(() {
                              themeMode = value!;
                            });
                          },
                        ),
                        RadioListTile<ThemeMode>(
                          title: Text(AppLocalizations.of(context)!
                              .themeMode('system')),
                          value: ThemeMode.system,
                          groupValue: themeMode,
                          onChanged: (value) {
                            setState(() {
                              themeMode = value!;
                            });
                          },
                        ),
                      ]),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => context.pop(),
                          child: Text(AppLocalizations.of(context)!.cancel),
                        ),
                        TextButton(
                          onPressed: () {
                            context.pop();
                            ref
                                .read(themeModeSettingProvider.notifier)
                                .changeTheme(themeMode);
                          },
                          child: Text(AppLocalizations.of(context)!.confirm),
                        ),
                      ],
                    );
                  }),
                );
              }),
          ListTile(
              title: Text(AppLocalizations.of(context)!.language),
              subtitle: Text(AppLocalizations.of(context)!
                  .languageMode(ref.watch(localeSettingProvider).toString())),
              onTap: () {
                Locale locale = ref.read(localeSettingProvider);
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) =>
                      StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      title: Text(AppLocalizations.of(context)!.language),
                      content:
                          Column(mainAxisSize: MainAxisSize.min, children: [
                        RadioListTile<Locale>(
                          title: Text(
                              AppLocalizations.of(context)!.languageMode('en')),
                          value: L10n.en,
                          groupValue: locale,
                          onChanged: (value) {
                            setState(() {
                              locale = value!;
                            });
                          },
                        ),
                        RadioListTile<Locale>(
                          title: Text(
                              AppLocalizations.of(context)!.languageMode('fa')),
                          value: L10n.fa,
                          groupValue: locale,
                          onChanged: (value) {
                            setState(() {
                              locale = value!;
                            });
                          },
                        ),
                        RadioListTile<Locale>(
                          title: Text(AppLocalizations.of(context)!
                              .themeMode('system')),
                          value: L10n.system,
                          groupValue: locale,
                          onChanged: (value) {
                            setState(() {
                              locale = value!;
                            });
                          },
                        ),
                      ]),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => context.pop(),
                          child: Text(AppLocalizations.of(context)!.cancel),
                        ),
                        TextButton(
                          onPressed: () {
                            context.pop();
                            ref
                                .read(localeSettingProvider.notifier)
                                .changeLocale(locale);
                          },
                          child: Text(AppLocalizations.of(context)!.confirm),
                        ),
                      ],
                    );
                  }),
                );
              }),
          const Divider(),
          ListTile(
            title: Text(AppLocalizations.of(context)!.createBackup),
            onTap: () async {
              Directory tempDir = await getTemporaryDirectory();
              File backupTemp = File("${tempDir.path}/backup.txt");
              await backupTemp.writeAsString(ref.read(backupStringProvider));
              await Share.shareXFiles([XFile("${tempDir.path}/backup.txt")]);
              backupTemp.delete();
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.restoreBackup),
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['txt'],
              );
              if (result != null) {
                File file = File(result.files.single.path!);
                String backupString = await file.readAsString();
                // String backupString = "Y2N8fnx7ImlkIjoiNWRmNTJmODAtYTAxOS0xZTU0LTlmMDgtZmY3NGFlZjUyOWM3IiwiYmdJZCI6IjYiLCJ0aXRsZSI6Itqp2KfYsdiqINmF2LrYp9iy2YciLCJuYW1lIjoi2LnZhNuMINmF2K3Zhdiv24wiLCJudW1iZXIiOiIxMjM0MTIzNDEyMzQxMjM0IiwiY3Z2MiI6IjEyMzQiLCJleHAiOiIxMC8wNiIsInNoYmEiOiItIiwicGFzcyI6Ii0iLCJub3RlIjoiLSIsImJhbmsiOnsibmFtZSI6Im1lbGxpIiwiY29kZSI6IjAifX18fnx7ImlkIjoiYzY1YTJlYTAtYTBhOS0xZTU0LTlmMDgtZmY3NGFlZjUyOWM3IiwiYmdJZCI6IjEiLCJ0aXRsZSI6Itm+2LMg2KfZhtiv2KfYsiIsIm5hbWUiOiLYsdi22Kcg2YXZiNiz2YjbjCIsIm51bWJlciI6IjEyMzQ1Njc4OTAxMjM0NTYiLCJjdnYyIjoiMzIxNCIsImV4cCI6IjAxLzAzIiwic2hiYSI6Ii0iLCJwYXNzIjoiLSIsIm5vdGUiOiItIiwiYmFuayI6eyJuYW1lIjoiYW5zYXIiLCJjb2RlIjoiMCJ9fXx+fnxuY3x+fHsiaWQiOiI0YWE4MzFiMC1hMzAzLTFlNTQtOWYwOC1mZjc0YWVmNTI5YzciLCJiZ0lkIjoiMyIsInRpdGxlIjoi2KLYr9ix2LMg2K7ZiNmG2Ycg2LnZhNuMIiwibm90ZSI6Itiq2YfYsdin2YYg2YXbjNiv2KfZhiDYp9mF2KfZhSDYrtuM2KfYqNin2YYg2LHYttmI24wg2b7ZhNin2qkg27HbsFxuIn0=";
                ref
                    .read(backupStringProvider.notifier)
                    .restoreBackup(backupString);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        AppLocalizations.of(context)!.restoreBackupDone,
                      ),
                    ),
                  );
                }
              }
            },
          ),
          const SizedBox(height: 36),
          const Text("Mini Wallet 1.5.0", style: TextStyle(color: Colors.grey)),
          const Text("Copyright © 2024 Timothy F. Turner",
              style: TextStyle(color: Colors.grey)),
          InkWell(
            onTap: _sendMail,
            child: const Text("TiimmyFTurner@gmail.com",
                style: TextStyle(color: Colors.grey)),
          ),
          InkWell(
            onTap: _openTelegram,
            child: const Text("T.me/TiimmyFTurner",
                style: TextStyle(color: Colors.grey)),
          ),
        ],
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
