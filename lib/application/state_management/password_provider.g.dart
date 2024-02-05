// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$passwordHash() => r'7bf8476c017c1a4263bc569d63425ed9a235d9c2';

/// See also [Password].
@ProviderFor(Password)
final passwordProvider = NotifierProvider<Password, String>.internal(
  Password.new,
  name: r'passwordProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$passwordHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Password = Notifier<String>;
String _$passwordStatusHash() => r'67416464c86310e46fda651dd48ec687f23ee338';

/// See also [PasswordStatus].
@ProviderFor(PasswordStatus)
final passwordStatusProvider =
    AutoDisposeNotifierProvider<PasswordStatus, bool>.internal(
  PasswordStatus.new,
  name: r'passwordStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$passwordStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PasswordStatus = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
