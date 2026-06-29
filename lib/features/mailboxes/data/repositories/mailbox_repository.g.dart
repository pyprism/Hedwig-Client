// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailbox_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mailboxRepository)
final mailboxRepositoryProvider = MailboxRepositoryProvider._();

final class MailboxRepositoryProvider
    extends
        $FunctionalProvider<
          MailboxRepository,
          MailboxRepository,
          MailboxRepository
        >
    with $Provider<MailboxRepository> {
  MailboxRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mailboxRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mailboxRepositoryHash();

  @$internal
  @override
  $ProviderElement<MailboxRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MailboxRepository create(Ref ref) {
    return mailboxRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MailboxRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MailboxRepository>(value),
    );
  }
}

String _$mailboxRepositoryHash() => r'c8f4997a1ca3ff42160eb17e3de2cb47887f090f';
