// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$adminDatasourceHash() => r'a71ede6eebe3fd2f45611dcf8ea7fb5e19dfc72f';

/// Provides the admin datasource.
///
/// Copied from [adminDatasource].
@ProviderFor(adminDatasource)
final adminDatasourceProvider =
    AutoDisposeProvider<AdminRemoteDatasource>.internal(
      adminDatasource,
      name: r'adminDatasourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$adminDatasourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AdminDatasourceRef = AutoDisposeProviderRef<AdminRemoteDatasource>;
String _$adminAgendaNotifierHash() =>
    r'428a4811fc0471ec57ac045cab2e8bf6bf6ad145';

/// Manages admin agenda (appointments for a specific date).
///
/// Copied from [AdminAgendaNotifier].
@ProviderFor(AdminAgendaNotifier)
final adminAgendaNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      AdminAgendaNotifier,
      List<AppointmentEntity>
    >.internal(
      AdminAgendaNotifier.new,
      name: r'adminAgendaNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$adminAgendaNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AdminAgendaNotifier =
    AutoDisposeAsyncNotifier<List<AppointmentEntity>>;
String _$adminCalendarNotifierHash() =>
    r'ef9158c9d72a5bdb10d1b51e91dda83d9cece5d4';

/// Manages admin calendar (appointments within date range).
///
/// Copied from [AdminCalendarNotifier].
@ProviderFor(AdminCalendarNotifier)
final adminCalendarNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      AdminCalendarNotifier,
      List<AppointmentEntity>
    >.internal(
      AdminCalendarNotifier.new,
      name: r'adminCalendarNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$adminCalendarNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AdminCalendarNotifier =
    AutoDisposeAsyncNotifier<List<AppointmentEntity>>;
String _$adminEmployeeNotifierHash() =>
    r'95a39760391cb876a99b42ca0ca26780616e0a5d';

/// See also [AdminEmployeeNotifier].
@ProviderFor(AdminEmployeeNotifier)
final adminEmployeeNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      AdminEmployeeNotifier,
      List<EmployeeEntity>
    >.internal(
      AdminEmployeeNotifier.new,
      name: r'adminEmployeeNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$adminEmployeeNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AdminEmployeeNotifier =
    AutoDisposeAsyncNotifier<List<EmployeeEntity>>;
String _$adminUserNotifierHash() => r'3d2fb9cbd83d3e1e57eb67b0dfe5d813525e734a';

/// See also [AdminUserNotifier].
@ProviderFor(AdminUserNotifier)
final adminUserNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      AdminUserNotifier,
      List<AdminUserEntity>
    >.internal(
      AdminUserNotifier.new,
      name: r'adminUserNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$adminUserNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AdminUserNotifier = AutoDisposeAsyncNotifier<List<AdminUserEntity>>;
String _$adminVehicleNotifierHash() =>
    r'8d97c4502dfb77df0b18c5b8f7fe12c2b0eeb448';

/// See also [AdminVehicleNotifier].
@ProviderFor(AdminVehicleNotifier)
final adminVehicleNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      AdminVehicleNotifier,
      List<VehicleEntity>
    >.internal(
      AdminVehicleNotifier.new,
      name: r'adminVehicleNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$adminVehicleNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AdminVehicleNotifier = AutoDisposeAsyncNotifier<List<VehicleEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
