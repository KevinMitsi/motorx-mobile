// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appointmentRepositoryHash() =>
    r'bed29e3a8b5319b08822c8d898dea5b4fc5dc589';

/// Provides the [AppointmentRepository] instance.
///
/// Copied from [appointmentRepository].
@ProviderFor(appointmentRepository)
final appointmentRepositoryProvider =
    AutoDisposeProvider<AppointmentRepository>.internal(
      appointmentRepository,
      name: r'appointmentRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$appointmentRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppointmentRepositoryRef =
    AutoDisposeProviderRef<AppointmentRepository>;
String _$appointmentListNotifierHash() =>
    r'abc489474af4bac7bc5044c100ff78451781e24b';

/// Manages the list of user appointments.
///
/// Copied from [AppointmentListNotifier].
@ProviderFor(AppointmentListNotifier)
final appointmentListNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      AppointmentListNotifier,
      List<AppointmentEntity>
    >.internal(
      AppointmentListNotifier.new,
      name: r'appointmentListNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$appointmentListNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AppointmentListNotifier =
    AutoDisposeAsyncNotifier<List<AppointmentEntity>>;
String _$availableSlotsNotifierHash() =>
    r'dde31e6e2ec468b07f6565387ceacd84abcf9baa';

/// Provider for available slots (date + type → slots).
///
/// Copied from [AvailableSlotsNotifier].
@ProviderFor(AvailableSlotsNotifier)
final availableSlotsNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      AvailableSlotsNotifier,
      AvailableSlotsEntity?
    >.internal(
      AvailableSlotsNotifier.new,
      name: r'availableSlotsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$availableSlotsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AvailableSlotsNotifier =
    AutoDisposeAsyncNotifier<AvailableSlotsEntity?>;
String _$plateRestrictionNotifierHash() =>
    r'ad080519d3ad42fce92cbed4bc3a709d124a8b46';

/// Provider for plate restriction check.
///
/// Copied from [PlateRestrictionNotifier].
@ProviderFor(PlateRestrictionNotifier)
final plateRestrictionNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      PlateRestrictionNotifier,
      PlateRestrictionEntity?
    >.internal(
      PlateRestrictionNotifier.new,
      name: r'plateRestrictionNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$plateRestrictionNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PlateRestrictionNotifier =
    AutoDisposeAsyncNotifier<PlateRestrictionEntity?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
