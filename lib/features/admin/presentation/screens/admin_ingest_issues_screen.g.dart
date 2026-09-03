// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_ingest_issues_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adminIngestIssues)
final adminIngestIssuesProvider = AdminIngestIssuesProvider._();

final class AdminIngestIssuesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<IngestIssue>>,
          List<IngestIssue>,
          FutureOr<List<IngestIssue>>
        >
    with
        $FutureModifier<List<IngestIssue>>,
        $FutureProvider<List<IngestIssue>> {
  AdminIngestIssuesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminIngestIssuesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminIngestIssuesHash();

  @$internal
  @override
  $FutureProviderElement<List<IngestIssue>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<IngestIssue>> create(Ref ref) {
    return adminIngestIssues(ref);
  }
}

String _$adminIngestIssuesHash() => r'680db9197961e5d45981ac03783c8247b5039147';
