// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outbox_badge.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pendingOutboxCount)
final pendingOutboxCountProvider = PendingOutboxCountProvider._();

final class PendingOutboxCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, Stream<int>>
    with $FutureModifier<int>, $StreamProvider<int> {
  PendingOutboxCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingOutboxCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingOutboxCountHash();

  @$internal
  @override
  $StreamProviderElement<int> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<int> create(Ref ref) {
    return pendingOutboxCount(ref);
  }
}

String _$pendingOutboxCountHash() =>
    r'1e7c3e48856f877b46fc9b40e6a36bae0234e042';

@ProviderFor(deadLetterOutboxCount)
final deadLetterOutboxCountProvider = DeadLetterOutboxCountProvider._();

final class DeadLetterOutboxCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, Stream<int>>
    with $FutureModifier<int>, $StreamProvider<int> {
  DeadLetterOutboxCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deadLetterOutboxCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deadLetterOutboxCountHash();

  @$internal
  @override
  $StreamProviderElement<int> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<int> create(Ref ref) {
    return deadLetterOutboxCount(ref);
  }
}

String _$deadLetterOutboxCountHash() =>
    r'1daee535a8b9436ac1e1a253c41382018902bb21';
