// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_delivery_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adminDeliveryEvents)
final adminDeliveryEventsProvider = AdminDeliveryEventsProvider._();

final class AdminDeliveryEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DeliveryEvent>>,
          List<DeliveryEvent>,
          FutureOr<List<DeliveryEvent>>
        >
    with
        $FutureModifier<List<DeliveryEvent>>,
        $FutureProvider<List<DeliveryEvent>> {
  AdminDeliveryEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminDeliveryEventsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminDeliveryEventsHash();

  @$internal
  @override
  $FutureProviderElement<List<DeliveryEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DeliveryEvent>> create(Ref ref) {
    return adminDeliveryEvents(ref);
  }
}

String _$adminDeliveryEventsHash() =>
    r'821ac9f5c351a5d2b64a7866096fd1b7acd673bd';
