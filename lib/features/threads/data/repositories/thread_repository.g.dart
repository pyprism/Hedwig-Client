// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(threadRepository)
final threadRepositoryProvider = ThreadRepositoryProvider._();

final class ThreadRepositoryProvider
    extends
        $FunctionalProvider<
          ThreadRepository,
          ThreadRepository,
          ThreadRepository
        >
    with $Provider<ThreadRepository> {
  ThreadRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'threadRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$threadRepositoryHash();

  @$internal
  @override
  $ProviderElement<ThreadRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ThreadRepository create(Ref ref) {
    return threadRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThreadRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThreadRepository>(value),
    );
  }
}

String _$threadRepositoryHash() => r'142436c92221e6cf7e81bbdaf06ef8d0b1d06dfe';

@ProviderFor(threadCounts)
final threadCountsProvider = ThreadCountsFamily._();

final class ThreadCountsProvider
    extends
        $FunctionalProvider<
          AsyncValue<ThreadCounts>,
          ThreadCounts,
          FutureOr<ThreadCounts>
        >
    with $FutureModifier<ThreadCounts>, $FutureProvider<ThreadCounts> {
  ThreadCountsProvider._({
    required ThreadCountsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'threadCountsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$threadCountsHash();

  @override
  String toString() {
    return r'threadCountsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ThreadCounts> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ThreadCounts> create(Ref ref) {
    final argument = this.argument as String;
    return threadCounts(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ThreadCountsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$threadCountsHash() => r'b28533510caeaec0ddc3a211b819492a21116b82';

final class ThreadCountsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ThreadCounts>, String> {
  ThreadCountsFamily._()
    : super(
        retry: null,
        name: r'threadCountsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ThreadCountsProvider call(String mailboxId) =>
      ThreadCountsProvider._(argument: mailboxId, from: this);

  @override
  String toString() => r'threadCountsProvider';
}
