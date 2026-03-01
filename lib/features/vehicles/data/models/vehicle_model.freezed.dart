// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicle_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

VehicleModel _$VehicleModelFromJson(Map<String, dynamic> json) {
  return _VehicleModel.fromJson(json);
}

/// @nodoc
mixin _$VehicleModel {
  int get id => throw _privateConstructorUsedError;
  String get brand => throw _privateConstructorUsedError;
  String get model => throw _privateConstructorUsedError;
  int get yearOfManufacture => throw _privateConstructorUsedError;
  String get licensePlate => throw _privateConstructorUsedError;
  int get cylinderCapacity => throw _privateConstructorUsedError;
  String get chassisNumber => throw _privateConstructorUsedError;
  int get ownerId => throw _privateConstructorUsedError;
  String get ownerName => throw _privateConstructorUsedError;
  String get ownerEmail => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this VehicleModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VehicleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VehicleModelCopyWith<VehicleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VehicleModelCopyWith<$Res> {
  factory $VehicleModelCopyWith(
    VehicleModel value,
    $Res Function(VehicleModel) then,
  ) = _$VehicleModelCopyWithImpl<$Res, VehicleModel>;
  @useResult
  $Res call({
    int id,
    String brand,
    String model,
    int yearOfManufacture,
    String licensePlate,
    int cylinderCapacity,
    String chassisNumber,
    int ownerId,
    String ownerName,
    String ownerEmail,
    String createdAt,
    String updatedAt,
  });
}

/// @nodoc
class _$VehicleModelCopyWithImpl<$Res, $Val extends VehicleModel>
    implements $VehicleModelCopyWith<$Res> {
  _$VehicleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VehicleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? brand = null,
    Object? model = null,
    Object? yearOfManufacture = null,
    Object? licensePlate = null,
    Object? cylinderCapacity = null,
    Object? chassisNumber = null,
    Object? ownerId = null,
    Object? ownerName = null,
    Object? ownerEmail = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            brand: null == brand
                ? _value.brand
                : brand // ignore: cast_nullable_to_non_nullable
                      as String,
            model: null == model
                ? _value.model
                : model // ignore: cast_nullable_to_non_nullable
                      as String,
            yearOfManufacture: null == yearOfManufacture
                ? _value.yearOfManufacture
                : yearOfManufacture // ignore: cast_nullable_to_non_nullable
                      as int,
            licensePlate: null == licensePlate
                ? _value.licensePlate
                : licensePlate // ignore: cast_nullable_to_non_nullable
                      as String,
            cylinderCapacity: null == cylinderCapacity
                ? _value.cylinderCapacity
                : cylinderCapacity // ignore: cast_nullable_to_non_nullable
                      as int,
            chassisNumber: null == chassisNumber
                ? _value.chassisNumber
                : chassisNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            ownerId: null == ownerId
                ? _value.ownerId
                : ownerId // ignore: cast_nullable_to_non_nullable
                      as int,
            ownerName: null == ownerName
                ? _value.ownerName
                : ownerName // ignore: cast_nullable_to_non_nullable
                      as String,
            ownerEmail: null == ownerEmail
                ? _value.ownerEmail
                : ownerEmail // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VehicleModelImplCopyWith<$Res>
    implements $VehicleModelCopyWith<$Res> {
  factory _$$VehicleModelImplCopyWith(
    _$VehicleModelImpl value,
    $Res Function(_$VehicleModelImpl) then,
  ) = __$$VehicleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String brand,
    String model,
    int yearOfManufacture,
    String licensePlate,
    int cylinderCapacity,
    String chassisNumber,
    int ownerId,
    String ownerName,
    String ownerEmail,
    String createdAt,
    String updatedAt,
  });
}

/// @nodoc
class __$$VehicleModelImplCopyWithImpl<$Res>
    extends _$VehicleModelCopyWithImpl<$Res, _$VehicleModelImpl>
    implements _$$VehicleModelImplCopyWith<$Res> {
  __$$VehicleModelImplCopyWithImpl(
    _$VehicleModelImpl _value,
    $Res Function(_$VehicleModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VehicleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? brand = null,
    Object? model = null,
    Object? yearOfManufacture = null,
    Object? licensePlate = null,
    Object? cylinderCapacity = null,
    Object? chassisNumber = null,
    Object? ownerId = null,
    Object? ownerName = null,
    Object? ownerEmail = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$VehicleModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        brand: null == brand
            ? _value.brand
            : brand // ignore: cast_nullable_to_non_nullable
                  as String,
        model: null == model
            ? _value.model
            : model // ignore: cast_nullable_to_non_nullable
                  as String,
        yearOfManufacture: null == yearOfManufacture
            ? _value.yearOfManufacture
            : yearOfManufacture // ignore: cast_nullable_to_non_nullable
                  as int,
        licensePlate: null == licensePlate
            ? _value.licensePlate
            : licensePlate // ignore: cast_nullable_to_non_nullable
                  as String,
        cylinderCapacity: null == cylinderCapacity
            ? _value.cylinderCapacity
            : cylinderCapacity // ignore: cast_nullable_to_non_nullable
                  as int,
        chassisNumber: null == chassisNumber
            ? _value.chassisNumber
            : chassisNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        ownerId: null == ownerId
            ? _value.ownerId
            : ownerId // ignore: cast_nullable_to_non_nullable
                  as int,
        ownerName: null == ownerName
            ? _value.ownerName
            : ownerName // ignore: cast_nullable_to_non_nullable
                  as String,
        ownerEmail: null == ownerEmail
            ? _value.ownerEmail
            : ownerEmail // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VehicleModelImpl implements _VehicleModel {
  const _$VehicleModelImpl({
    required this.id,
    required this.brand,
    required this.model,
    required this.yearOfManufacture,
    required this.licensePlate,
    required this.cylinderCapacity,
    required this.chassisNumber,
    required this.ownerId,
    required this.ownerName,
    required this.ownerEmail,
    required this.createdAt,
    required this.updatedAt,
  });

  factory _$VehicleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VehicleModelImplFromJson(json);

  @override
  final int id;
  @override
  final String brand;
  @override
  final String model;
  @override
  final int yearOfManufacture;
  @override
  final String licensePlate;
  @override
  final int cylinderCapacity;
  @override
  final String chassisNumber;
  @override
  final int ownerId;
  @override
  final String ownerName;
  @override
  final String ownerEmail;
  @override
  final String createdAt;
  @override
  final String updatedAt;

  @override
  String toString() {
    return 'VehicleModel(id: $id, brand: $brand, model: $model, yearOfManufacture: $yearOfManufacture, licensePlate: $licensePlate, cylinderCapacity: $cylinderCapacity, chassisNumber: $chassisNumber, ownerId: $ownerId, ownerName: $ownerName, ownerEmail: $ownerEmail, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VehicleModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.yearOfManufacture, yearOfManufacture) ||
                other.yearOfManufacture == yearOfManufacture) &&
            (identical(other.licensePlate, licensePlate) ||
                other.licensePlate == licensePlate) &&
            (identical(other.cylinderCapacity, cylinderCapacity) ||
                other.cylinderCapacity == cylinderCapacity) &&
            (identical(other.chassisNumber, chassisNumber) ||
                other.chassisNumber == chassisNumber) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.ownerName, ownerName) ||
                other.ownerName == ownerName) &&
            (identical(other.ownerEmail, ownerEmail) ||
                other.ownerEmail == ownerEmail) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    brand,
    model,
    yearOfManufacture,
    licensePlate,
    cylinderCapacity,
    chassisNumber,
    ownerId,
    ownerName,
    ownerEmail,
    createdAt,
    updatedAt,
  );

  /// Create a copy of VehicleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VehicleModelImplCopyWith<_$VehicleModelImpl> get copyWith =>
      __$$VehicleModelImplCopyWithImpl<_$VehicleModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VehicleModelImplToJson(this);
  }
}

abstract class _VehicleModel implements VehicleModel {
  const factory _VehicleModel({
    required final int id,
    required final String brand,
    required final String model,
    required final int yearOfManufacture,
    required final String licensePlate,
    required final int cylinderCapacity,
    required final String chassisNumber,
    required final int ownerId,
    required final String ownerName,
    required final String ownerEmail,
    required final String createdAt,
    required final String updatedAt,
  }) = _$VehicleModelImpl;

  factory _VehicleModel.fromJson(Map<String, dynamic> json) =
      _$VehicleModelImpl.fromJson;

  @override
  int get id;
  @override
  String get brand;
  @override
  String get model;
  @override
  int get yearOfManufacture;
  @override
  String get licensePlate;
  @override
  int get cylinderCapacity;
  @override
  String get chassisNumber;
  @override
  int get ownerId;
  @override
  String get ownerName;
  @override
  String get ownerEmail;
  @override
  String get createdAt;
  @override
  String get updatedAt;

  /// Create a copy of VehicleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VehicleModelImplCopyWith<_$VehicleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
