// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(threadList)
final threadListProvider = ThreadListFamily._();

final class ThreadListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MailThread>>,
          List<MailThread>,
          Stream<List<MailThread>>
        >
    with $FutureModifier<List<MailThread>>, $StreamProvider<List<MailThread>> {
  ThreadListProvider._({
    required ThreadListFamily super.from,
    required ({String mailboxId, String folder, String? search}) super.argument,
  }) : super(
         retry: null,
         name: r'threadListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$threadListHash();

  @override
  String toString() {
    return r'threadListProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<List<MailThread>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<MailThread>> create(Ref ref) {
    final argument =
        this.argument as ({String mailboxId, String folder, String? search});
    return threadList(
      ref,
      mailboxId: argument.mailboxId,
      folder: argument.folder,
      search: argument.search,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ThreadListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$threadListHash() => r'61c02de0127a945e35064c49deef9b24efba4c09';

final class ThreadListFamily extends $Family
    with
        $FunctionalFamilyOverride<
          Stream<List<MailThread>>,
          ({String mailboxId, String folder, String? search})
        > {
  ThreadListFamily._()
    : super(
        retry: null,
        name: r'threadListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ThreadListProvider call({
    required String mailboxId,
    String folder = 'inbox',
    String? search,
  }) => ThreadListProvider._(
    argument: (mailboxId: mailboxId, folder: folder, search: search),
    from: this,
  );

  @override
  String toString() => r'threadListProvider';
}

/// Selected thread for two-pane layout on expanded screens.

@ProviderFor(SelectedThread)
final selectedThreadProvider = SelectedThreadProvider._();

/// Selected thread for two-pane layout on expanded screens.
final class SelectedThreadProvider
    extends $NotifierProvider<SelectedThread, String?> {
  /// Selected thread for two-pane layout on expanded screens.
  SelectedThreadProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedThreadProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedThreadHash();

  @$internal
  @override
  SelectedThread create() => SelectedThread();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedThreadHash() => r'69d8988ea0173942c7e11a218ff39e40d60efa36';

/// Selected thread for two-pane layout on expanded screens.

abstract class _$SelectedThread extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
