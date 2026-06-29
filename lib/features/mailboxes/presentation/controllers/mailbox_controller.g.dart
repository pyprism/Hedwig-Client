// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailbox_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mailboxListHash() => r'22f2dd0956a90b8e0f38110350692300d9fb731f';

/// See also [mailboxList].
@ProviderFor(mailboxList)
final mailboxListProvider = AutoDisposeStreamProvider<List<Mailbox>>.internal(
  mailboxList,
  name: r'mailboxListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mailboxListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MailboxListRef = AutoDisposeStreamProviderRef<List<Mailbox>>;
String _$selectedMailboxHash() => r'4810073411fec6905a806c1dc45899eeb5bb2e23';

/// The currently selected mailbox id.
///
/// Copied from [SelectedMailbox].
@ProviderFor(SelectedMailbox)
final selectedMailboxProvider =
    NotifierProvider<SelectedMailbox, String?>.internal(
      SelectedMailbox.new,
      name: r'selectedMailboxProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$selectedMailboxHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedMailbox = Notifier<String?>;
String _$selectedFolderHash() => r'ee7536713c6d81e69081a2ac2e590b2bd4e97237';

/// The currently selected folder name.
///
/// Copied from [SelectedFolder].
@ProviderFor(SelectedFolder)
final selectedFolderProvider =
    NotifierProvider<SelectedFolder, String>.internal(
      SelectedFolder.new,
      name: r'selectedFolderProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$selectedFolderHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedFolder = Notifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
