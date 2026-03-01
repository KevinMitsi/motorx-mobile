// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$vehicleListNotifierHash() =>
    r'e0dedacf9e6324e7aed04def999c1774ad016a5c';

/// Notifier for user's vehicle list.
///
/// Copied from [VehicleListNotifier].
@ProviderFor(VehicleListNotifier)
final vehicleListNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      VehicleListNotifier,
      List<VehicleEntity>
    >.internal(
      VehicleListNotifier.new,
      name: r'vehicleListNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$vehicleListNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$VehicleListNotifier = AutoDisposeAsyncNotifier<List<VehicleEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
