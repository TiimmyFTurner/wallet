import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:go_router/go_router.dart';
import 'package:wallet/application/state_management/first_time_provider.dart';
import 'package:wallet/application/state_management/password_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  const PasswordScreen({super.key});

  @override
  ConsumerState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends ConsumerState<PasswordScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (ref.read(firstTimeProvider)) {
        await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(AppLocalizations.of(context)!.privacyPolicy),
                content: Text(
                    AppLocalizations.of(context)!.privacyPolicyMessage,
                    textAlign: TextAlign.justify),
                actions: <Widget>[
                  TextButton(
                    child: Text(AppLocalizations.of(context)!.ok),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ],
              );
            });
      } else if (!ref.read(passwordStatusProvider)) {
        context.pushReplacementNamed("home");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final String password = ref.watch(passwordProvider);
    final bool firstTime = ref.read(firstTimeProvider);
    final bool passwordStatus = ref.read(passwordStatusProvider);

    return Scaffold(
      body: firstTime
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48),
                    child: Image.asset('assets/theme/password.png'),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    AppLocalizations.of(context)!.setPasswordMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 12),
                  FilledButton.tonal(
                    onPressed: () {
                      screenLockCreate(
                          context: context,
                          title:
                              Text(AppLocalizations.of(context)!.enterPassword),
                          cancelButton:
                              Text(AppLocalizations.of(context)!.cancel),
                          confirmTitle: Text(
                              AppLocalizations.of(context)!.confirmPassword),
                          onConfirmed: (value) {
                            ref
                                .read(passwordProvider.notifier)
                                .setPassword(value);
                            ref.read(firstTimeProvider.notifier).toggle();
                            context.pushReplacementNamed("home");
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        AppLocalizations.of(context)!.setPassword,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  FilledButton.tonal(
                      onPressed: () {
                        ref.read(firstTimeProvider.notifier).toggle();
                        context.pushReplacementNamed("home");
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          AppLocalizations.of(context)!.useAppWithoutPassword,
                          style: const TextStyle(fontSize: 18),
                        ),
                      )),
                  const SizedBox(height: 50)
                ],
              ),
            )
          : passwordStatus
              ? ScreenLock(
                  title: Text(AppLocalizations.of(context)!.enterPassword),
                  correctString: password,
                  onCancelled: null,
                  onUnlocked: () => context.pushReplacementNamed("home"),
                )
              : Container(),
    );
  }
}
