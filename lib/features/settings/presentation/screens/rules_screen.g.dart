// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rules_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mailboxRules)
final mailboxRulesProvider = MailboxRulesFamily._();

final class MailboxRulesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MailboxRule>>,
          List<MailboxRule>,
          FutureOr<List<MailboxRule>>
        >
    with
        $FutureModifier<List<MailboxRule>>,
        $FutureProvider<List<MailboxRule>> {
  MailboxRulesProvider._({
    required MailboxRulesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'mailboxRulesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$mailboxRulesHash();

  @override
  String toString() {
    return r'mailboxRulesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<MailboxRule>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MailboxRule>> create(Ref ref) {
    final argument = this.argument as String;
    return mailboxRules(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MailboxRulesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mailboxRulesHash() => r'09427424940ab9d367eda4ddfb0af86ca129299c';

final class MailboxRulesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<MailboxRule>>, String> {
  MailboxRulesFamily._()
    : super(
        retry: null,
        name: r'mailboxRulesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MailboxRulesProvider call(String mailboxId) =>
      MailboxRulesProvider._(argument: mailboxId, from: this);

  @override
  String toString() => r'mailboxRulesProvider';
}
