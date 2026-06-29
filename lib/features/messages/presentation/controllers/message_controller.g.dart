// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(threadMessages)
final threadMessagesProvider = ThreadMessagesFamily._();

final class ThreadMessagesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MailMessage>>,
          List<MailMessage>,
          Stream<List<MailMessage>>
        >
    with
        $FutureModifier<List<MailMessage>>,
        $StreamProvider<List<MailMessage>> {
  ThreadMessagesProvider._({
    required ThreadMessagesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'threadMessagesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$threadMessagesHash();

  @override
  String toString() {
    return r'threadMessagesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<MailMessage>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<MailMessage>> create(Ref ref) {
    final argument = this.argument as String;
    return threadMessages(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ThreadMessagesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$threadMessagesHash() => r'aa5276ccc68de2a209a68b6fe77409fadb560dbc';

final class ThreadMessagesFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<MailMessage>>, String> {
  ThreadMessagesFamily._()
    : super(
        retry: null,
        name: r'threadMessagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ThreadMessagesProvider call(String threadId) =>
      ThreadMessagesProvider._(argument: threadId, from: this);

  @override
  String toString() => r'threadMessagesProvider';
}

@ProviderFor(MessageStateController)
final messageStateControllerProvider = MessageStateControllerProvider._();

final class MessageStateControllerProvider
    extends $NotifierProvider<MessageStateController, AsyncValue<void>> {
  MessageStateControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'messageStateControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$messageStateControllerHash();

  @$internal
  @override
  MessageStateController create() => MessageStateController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$messageStateControllerHash() =>
    r'b8e5354564e7465609ff57c9a8d9451805f9d9b1';

abstract class _$MessageStateController extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
