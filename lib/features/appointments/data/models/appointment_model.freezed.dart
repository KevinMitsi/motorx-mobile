// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppointmentModel _$AppointmentModelFromJson(Map<String, dynamic> json) {
  return _AppointmentModel.fromJson(json);
}

/// @nodoc
mixin _$AppointmentModel {
  int get id => throw _privateConstructorUsedError;
  String get appointmentType => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get appointmentDate => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;
  int get vehicleId => throw _privateConstructorUsedError;
  String get vehiclePlate => throw _privateConstructorUsedError;
  String get vehicleBrand => throw _privateConstructorUsedError;
  String get vehicleModel => throw _privateConstructorUsedError;
  int get clientId => throw _privateConstructorUsedError;
  String get clientFullName => throw _privateConstructorUsedError;
  String get clientEmail => throw _privateConstructorUsedError;
  int? get technicianId => throw _privateConstructorUsedError;
  String? get technicianFullName => throw _privateConstructorUsedError;
  int get currentMileage => throw _privateConstructorUsedError;
  String? get clientNotes => throw _privateConstructorUsedError;
  String? get adminNotes => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this AppointmentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppointmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppointmentModelCopyWith<AppointmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentModelCopyWith<$Res> {
  factory $AppointmentModelCopyWith(
    AppointmentModel value,
    $Res Function(AppointmentModel) then,
  ) = _$AppointmentModelCopyWithImpl<$Res, AppointmentModel>;
  @useResult
  $Res call({
    int id,
    String appointmentType,
    String status,
    String appointmentDate,
    String startTime,
    String endTime,
    int vehicleId,
    String vehiclePlate,
    String vehicleBrand,
    String vehicleModel,
    int clientId,
    String clientFullName,
    String clientEmail,
    int? technicianId,
    String? technicianFullName,
    int currentMileage,
    String? clientNotes,
    String? adminNotes,
    String createdAt,
    String? updatedAt,
  });
}

/// @nodoc
class _$AppointmentModelCopyWithImpl<$Res, $Val extends AppointmentModel>
    implements $AppointmentModelCopyWith<$Res> {
  _$AppointmentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppointmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? appointmentType = null,
    Object? status = null,
    Object? appointmentDate = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? vehicleId = null,
    Object? vehiclePlate = null,
    Object? vehicleBrand = null,
    Object? vehicleModel = null,
    Object? clientId = null,
    Object? clientFullName = null,
    Object? clientEmail = null,
    Object? technicianId = freezed,
    Object? technicianFullName = freezed,
    Object? currentMileage = null,
    Object? clientNotes = freezed,
    Object? adminNotes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            appointmentType: null == appointmentType
                ? _value.appointmentType
                : appointmentType // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            appointmentDate: null == appointmentDate
                ? _value.appointmentDate
                : appointmentDate // ignore: cast_nullable_to_non_nullable
                      as String,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as String,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as String,
            vehicleId: null == vehicleId
                ? _value.vehicleId
                : vehicleId // ignore: cast_nullable_to_non_nullable
                      as int,
            vehiclePlate: null == vehiclePlate
                ? _value.vehiclePlate
                : vehiclePlate // ignore: cast_nullable_to_non_nullable
                      as String,
            vehicleBrand: null == vehicleBrand
                ? _value.vehicleBrand
                : vehicleBrand // ignore: cast_nullable_to_non_nullable
                      as String,
            vehicleModel: null == vehicleModel
                ? _value.vehicleModel
                : vehicleModel // ignore: cast_nullable_to_non_nullable
                      as String,
            clientId: null == clientId
                ? _value.clientId
                : clientId // ignore: cast_nullable_to_non_nullable
                      as int,
            clientFullName: null == clientFullName
                ? _value.clientFullName
                : clientFullName // ignore: cast_nullable_to_non_nullable
                      as String,
            clientEmail: null == clientEmail
                ? _value.clientEmail
                : clientEmail // ignore: cast_nullable_to_non_nullable
                      as String,
            technicianId: freezed == technicianId
                ? _value.technicianId
                : technicianId // ignore: cast_nullable_to_non_nullable
                      as int?,
            technicianFullName: freezed == technicianFullName
                ? _value.technicianFullName
                : technicianFullName // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentMileage: null == currentMileage
                ? _value.currentMileage
                : currentMileage // ignore: cast_nullable_to_non_nullable
                      as int,
            clientNotes: freezed == clientNotes
                ? _value.clientNotes
                : clientNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            adminNotes: freezed == adminNotes
                ? _value.adminNotes
                : adminNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_nullable
                  as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppointmentModelImplCopyWith<$Res>
    implements $AppointmentModelCopyWith<$Res> {
  factory _$$AppointmentModelImplCopyWith(
    _$AppointmentModelImpl value,
    $Res Function(_$AppointmentModelImpl) then,
  ) = __$$AppointmentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String appointmentType,
    String status,
    String appointmentDate,
    String startTime,
    String endTime,
    int vehicleId,
    String vehiclePlate,
    String vehicleBrand,
    String vehicleModel,
    int clientId,
    String clientFullName,
    String clientEmail,
    int? technicianId,
    String? technicianFullName,
    int currentMileage,
    String? clientNotes,
    String? adminNotes,
    String createdAt,
    String? updatedAt,
  });
}

/// @nodoc
class __$$AppointmentModelImplCopyWithImpl<$Res>
    extends _$AppointmentModelCopyWithImpl<$Res, _$AppointmentModelImpl>
    implements _$$AppointmentModelImplCopyWith<$Res> {
  __$$AppointmentModelImplCopyWithImpl(
    _$AppointmentModelImpl _value,
    $Res Function(_$AppointmentModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppointmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? appointmentType = null,
    Object? status = null,
    Object? appointmentDate = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? vehicleId = null,
    Object? vehiclePlate = null,
    Object? vehicleBrand = null,
    Object? vehicleModel = null,
    Object? clientId = null,
    Object? clientFullName = null,
    Object? clientEmail = null,
    Object? technicianId = freezed,
    Object? technicianFullName = freezed,
    Object? currentMileage = null,
    Object? clientNotes = freezed,
    Object? adminNotes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$AppointmentModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        appointmentType: null == appointmentType
            ? _value.appointmentType
            : appointmentType // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        appointmentDate: null == appointmentDate
            ? _value.appointmentDate
            : appointmentDate // ignore: cast_nullable_to_non_nullable
                  as String,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as String,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as String,
        vehicleId: null == vehicleId
            ? _value.vehicleId
            : vehicleId // ignore: cast_nullable_to_non_nullable
                  as int,
        vehiclePlate: null == vehiclePlate
            ? _value.vehiclePlate
            : vehiclePlate // ignore: cast_nullable_to_non_nullable
                  as String,
        vehicleBrand: null == vehicleBrand
            ? _value.vehicleBrand
            : vehicleBrand // ignore: cast_nullable_to_non_nullable
                  as String,
        vehicleModel: null == vehicleModel
            ? _value.vehicleModel
            : vehicleModel // ignore: cast_nullable_to_non_nullable
                  as String,
        clientId: null == clientId
            ? _value.clientId
            : clientId // ignore: cast_nullable_to_non_nullable
                  as int,
        clientFullName: null == clientFullName
            ? _value.clientFullName
            : clientFullName // ignore: cast_nullable_to_non_nullable
                  as String,
        clientEmail: null == clientEmail
            ? _value.clientEmail
            : clientEmail // ignore: cast_nullable_to_non_nullable
                  as String,
        technicianId: freezed == technicianId
            ? _value.technicianId
            : technicianId // ignore: cast_nullable_to_non_nullable
                  as int?,
        technicianFullName: freezed == technicianFullName
            ? _value.technicianFullName
            : technicianFullName // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentMileage: null == currentMileage
            ? _value.currentMileage
            : currentMileage // ignore: cast_nullable_to_non_nullable
                  as int,
        clientNotes: freezed == clientNotes
            ? _value.clientNotes
            : clientNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        adminNotes: freezed == adminNotes
            ? _value.adminNotes
            : adminNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AppointmentModelImpl implements _AppointmentModel {
  const _$AppointmentModelImpl({
    required this.id,
    required this.appointmentType,
    required this.status,
    required this.appointmentDate,
    required this.startTime,
    required this.endTime,
    required this.vehicleId,
    required this.vehiclePlate,
    required this.vehicleBrand,
    required this.vehicleModel,
    required this.clientId,
    required this.clientFullName,
    required this.clientEmail,
    this.technicianId,
    this.technicianFullName,
    required this.currentMileage,
    this.clientNotes,
    this.adminNotes,
    required this.createdAt,
    this.updatedAt,
  });

  factory _$AppointmentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppointmentModelImplFromJson(json);

  @override
  final int id;
  @override
  final String appointmentType;
  @override
  final String status;
  @override
  final String appointmentDate;
  @override
  final String startTime;
  @override
  final String endTime;
  @override
  final int vehicleId;
  @override
  final String vehiclePlate;
  @override
  final String vehicleBrand;
  @override
  final String vehicleModel;
  @override
  final int clientId;
  @override
  final String clientFullName;
  @override
  final String clientEmail;
  @override
  final int? technicianId;
  @override
  final String? technicianFullName;
  @override
  final int currentMileage;
  @override
  final String? clientNotes;
  @override
  final String? adminNotes;
  @override
  final String createdAt;
  @override
  final String? updatedAt;

  @override
  String toString() {
    return 'AppointmentModel(id: $id, appointmentType: $appointmentType, status: $status, appointmentDate: $appointmentDate, startTime: $startTime, endTime: $endTime, vehicleId: $vehicleId, vehiclePlate: $vehiclePlate, vehicleBrand: $vehicleBrand, vehicleModel: $vehicleModel, clientId: $clientId, clientFullName: $clientFullName, clientEmail: $clientEmail, technicianId: $technicianId, technicianFullName: $technicianFullName, currentMileage: $currentMileage, clientNotes: $clientNotes, adminNotes: $adminNotes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.appointmentType, appointmentType) ||
                other.appointmentType == appointmentType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.appointmentDate, appointmentDate) ||
                other.appointmentDate == appointmentDate) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.vehicleId, vehicleId) ||
                other.vehicleId == vehicleId) &&
            (identical(other.vehiclePlate, vehiclePlate) ||
                other.vehiclePlate == vehiclePlate) &&
            (identical(other.vehicleBrand, vehicleBrand) ||
                other.vehicleBrand == vehicleBrand) &&
            (identical(other.vehicleModel, vehicleModel) ||
                other.vehicleModel == vehicleModel) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientFullName, clientFullName) ||
                other.clientFullName == clientFullName) &&
            (identical(other.clientEmail, clientEmail) ||
                other.clientEmail == clientEmail) &&
            (identical(other.technicianId, technicianId) ||
                other.technicianId == technicianId) &&
            (identical(other.technicianFullName, technicianFullName) ||
                other.technicianFullName == technicianFullName) &&
            (identical(other.currentMileage, currentMileage) ||
                other.currentMileage == currentMileage) &&
            (identical(other.clientNotes, clientNotes) ||
                other.clientNotes == clientNotes) &&
            (identical(other.adminNotes, adminNotes) ||
                other.adminNotes == adminNotes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    appointmentType,
    status,
    appointmentDate,
    startTime,
    endTime,
    vehicleId,
    vehiclePlate,
    vehicleBrand,
    vehicleModel,
    clientId,
    clientFullName,
    clientEmail,
    technicianId,
    technicianFullName,
    currentMileage,
    clientNotes,
    adminNotes,
    createdAt,
    updatedAt,
  ]);

  /// Create a copy of AppointmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentModelImplCopyWith<_$AppointmentModelImpl> get copyWith =>
      __$$AppointmentModelImplCopyWithImpl<_$AppointmentModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AppointmentModelImplToJson(this);
  }
}

abstract class _AppointmentModel implements AppointmentModel {
  const factory _AppointmentModel({
    required final int id,
    required final String appointmentType,
    required final String status,
    required final String appointmentDate,
    required final String startTime,
    required final String endTime,
    required final int vehicleId,
    required final String vehiclePlate,
    required final String vehicleBrand,
    required final String vehicleModel,
    required final int clientId,
    required final String clientFullName,
    required final String clientEmail,
    final int? technicianId,
    final String? technicianFullName,
    required final int currentMileage,
    final String? clientNotes,
    final String? adminNotes,
    required final String createdAt,
    final String? updatedAt,
  }) = _$AppointmentModelImpl;

  factory _AppointmentModel.fromJson(Map<String, dynamic> json) =
      _$AppointmentModelImpl.fromJson;

  @override
  int get id;
  @override
  String get appointmentType;
  @override
  String get status;
  @override
  String get appointmentDate;
  @override
  String get startTime;
  @override
  String get endTime;
  @override
  int get vehicleId;
  @override
  String get vehiclePlate;
  @override
  String get vehicleBrand;
  @override
  String get vehicleModel;
  @override
  int get clientId;
  @override
  String get clientFullName;
  @override
  String get clientEmail;
  @override
  int? get technicianId;
  @override
  String? get technicianFullName;
  @override
  int get currentMileage;
  @override
  String? get clientNotes;
  @override
  String? get adminNotes;
  @override
  String get createdAt;
  @override
  String? get updatedAt;

  /// Create a copy of AppointmentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppointmentModelImplCopyWith<_$AppointmentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AvailableSlotsModel _$AvailableSlotsModelFromJson(Map<String, dynamic> json) {
  return _AvailableSlotsModel.fromJson(json);
}

/// @nodoc
mixin _$AvailableSlotsModel {
  String get date => throw _privateConstructorUsedError;
  String get appointmentType => throw _privateConstructorUsedError;
  List<AvailableSlotModel> get availableSlots =>
      throw _privateConstructorUsedError;

  /// Serializes this AvailableSlotsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AvailableSlotsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AvailableSlotsModelCopyWith<AvailableSlotsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvailableSlotsModelCopyWith<$Res> {
  factory $AvailableSlotsModelCopyWith(
    AvailableSlotsModel value,
    $Res Function(AvailableSlotsModel) then,
  ) = _$AvailableSlotsModelCopyWithImpl<$Res, AvailableSlotsModel>;
  @useResult
  $Res call({
    String date,
    String appointmentType,
    List<AvailableSlotModel> availableSlots,
  });
}

/// @nodoc
class _$AvailableSlotsModelCopyWithImpl<$Res, $Val extends AvailableSlotsModel>
    implements $AvailableSlotsModelCopyWith<$Res> {
  _$AvailableSlotsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AvailableSlotsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? appointmentType = null,
    Object? availableSlots = null,
  }) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            appointmentType: null == appointmentType
                ? _value.appointmentType
                : appointmentType // ignore: cast_nullable_to_non_nullable
                      as String,
            availableSlots: null == availableSlots
                ? _value.availableSlots
                : availableSlots // ignore: cast_nullable_to_non_nullable
                      as List<AvailableSlotModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AvailableSlotsModelImplCopyWith<$Res>
    implements $AvailableSlotsModelCopyWith<$Res> {
  factory _$$AvailableSlotsModelImplCopyWith(
    _$AvailableSlotsModelImpl value,
    $Res Function(_$AvailableSlotsModelImpl) then,
  ) = __$$AvailableSlotsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String date,
    String appointmentType,
    List<AvailableSlotModel> availableSlots,
  });
}

/// @nodoc
class __$$AvailableSlotsModelImplCopyWithImpl<$Res>
    extends _$AvailableSlotsModelCopyWithImpl<$Res, _$AvailableSlotsModelImpl>
    implements _$$AvailableSlotsModelImplCopyWith<$Res> {
  __$$AvailableSlotsModelImplCopyWithImpl(
    _$AvailableSlotsModelImpl _value,
    $Res Function(_$AvailableSlotsModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AvailableSlotsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? appointmentType = null,
    Object? availableSlots = null,
  }) {
    return _then(
      _$AvailableSlotsModelImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        appointmentType: null == appointmentType
            ? _value.appointmentType
            : appointmentType // ignore: cast_nullable_to_non_nullable
                  as String,
        availableSlots: null == availableSlots
            ? _value._availableSlots
            : availableSlots // ignore: cast_nullable_to_non_nullable
                  as List<AvailableSlotModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AvailableSlotsModelImpl implements _AvailableSlotsModel {
  const _$AvailableSlotsModelImpl({
    required this.date,
    required this.appointmentType,
    required final List<AvailableSlotModel> availableSlots,
  }) : _availableSlots = availableSlots;

  factory _$AvailableSlotsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AvailableSlotsModelImplFromJson(json);

  @override
  final String date;
  @override
  final String appointmentType;
  final List<AvailableSlotModel> _availableSlots;
  @override
  List<AvailableSlotModel> get availableSlots {
    if (_availableSlots is EqualUnmodifiableListView) return _availableSlots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableSlots);
  }

  @override
  String toString() {
    return 'AvailableSlotsModel(date: $date, appointmentType: $appointmentType, availableSlots: $availableSlots)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AvailableSlotsModelImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.appointmentType, appointmentType) ||
                other.appointmentType == appointmentType) &&
            const DeepCollectionEquality().equals(
              other._availableSlots,
              _availableSlots,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    appointmentType,
    const DeepCollectionEquality().hash(_availableSlots),
  );

  /// Create a copy of AvailableSlotsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AvailableSlotsModelImplCopyWith<_$AvailableSlotsModelImpl> get copyWith =>
      __$$AvailableSlotsModelImplCopyWithImpl<_$AvailableSlotsModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AvailableSlotsModelImplToJson(this);
  }
}

abstract class _AvailableSlotsModel implements AvailableSlotsModel {
  const factory _AvailableSlotsModel({
    required final String date,
    required final String appointmentType,
    required final List<AvailableSlotModel> availableSlots,
  }) = _$AvailableSlotsModelImpl;

  factory _AvailableSlotsModel.fromJson(Map<String, dynamic> json) =
      _$AvailableSlotsModelImpl.fromJson;

  @override
  String get date;
  @override
  String get appointmentType;
  @override
  List<AvailableSlotModel> get availableSlots;

  /// Create a copy of AvailableSlotsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AvailableSlotsModelImplCopyWith<_$AvailableSlotsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AvailableSlotModel _$AvailableSlotModelFromJson(Map<String, dynamic> json) {
  return _AvailableSlotModel.fromJson(json);
}

/// @nodoc
mixin _$AvailableSlotModel {
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;
  int get availableTechnicians => throw _privateConstructorUsedError;

  /// Serializes this AvailableSlotModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AvailableSlotModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AvailableSlotModelCopyWith<AvailableSlotModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvailableSlotModelCopyWith<$Res> {
  factory $AvailableSlotModelCopyWith(
    AvailableSlotModel value,
    $Res Function(AvailableSlotModel) then,
  ) = _$AvailableSlotModelCopyWithImpl<$Res, AvailableSlotModel>;
  @useResult
  $Res call({String startTime, String endTime, int availableTechnicians});
}

/// @nodoc
class _$AvailableSlotModelCopyWithImpl<$Res, $Val extends AvailableSlotModel>
    implements $AvailableSlotModelCopyWith<$Res> {
  _$AvailableSlotModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AvailableSlotModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startTime = null,
    Object? endTime = null,
    Object? availableTechnicians = null,
  }) {
    return _then(
      _value.copyWith(
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as String,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as String,
            availableTechnicians: null == availableTechnicians
                ? _value.availableTechnicians
                : availableTechnicians // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AvailableSlotModelImplCopyWith<$Res>
    implements $AvailableSlotModelCopyWith<$Res> {
  factory _$$AvailableSlotModelImplCopyWith(
    _$AvailableSlotModelImpl value,
    $Res Function(_$AvailableSlotModelImpl) then,
  ) = __$$AvailableSlotModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String startTime, String endTime, int availableTechnicians});
}

/// @nodoc
class __$$AvailableSlotModelImplCopyWithImpl<$Res>
    extends _$AvailableSlotModelCopyWithImpl<$Res, _$AvailableSlotModelImpl>
    implements _$$AvailableSlotModelImplCopyWith<$Res> {
  __$$AvailableSlotModelImplCopyWithImpl(
    _$AvailableSlotModelImpl _value,
    $Res Function(_$AvailableSlotModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AvailableSlotModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startTime = null,
    Object? endTime = null,
    Object? availableTechnicians = null,
  }) {
    return _then(
      _$AvailableSlotModelImpl(
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as String,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as String,
        availableTechnicians: null == availableTechnicians
            ? _value.availableTechnicians
            : availableTechnicians // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AvailableSlotModelImpl implements _AvailableSlotModel {
  const _$AvailableSlotModelImpl({
    required this.startTime,
    required this.endTime,
    required this.availableTechnicians,
  });

  factory _$AvailableSlotModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AvailableSlotModelImplFromJson(json);

  @override
  final String startTime;
  @override
  final String endTime;
  @override
  final int availableTechnicians;

  @override
  String toString() {
    return 'AvailableSlotModel(startTime: $startTime, endTime: $endTime, availableTechnicians: $availableTechnicians)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AvailableSlotModelImpl &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.availableTechnicians, availableTechnicians) ||
                other.availableTechnicians == availableTechnicians));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, startTime, endTime, availableTechnicians);

  /// Create a copy of AvailableSlotModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AvailableSlotModelImplCopyWith<_$AvailableSlotModelImpl> get copyWith =>
      __$$AvailableSlotModelImplCopyWithImpl<_$AvailableSlotModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AvailableSlotModelImplToJson(this);
  }
}

abstract class _AvailableSlotModel implements AvailableSlotModel {
  const factory _AvailableSlotModel({
    required final String startTime,
    required final String endTime,
    required final int availableTechnicians,
  }) = _$AvailableSlotModelImpl;

  factory _AvailableSlotModel.fromJson(Map<String, dynamic> json) =
      _$AvailableSlotModelImpl.fromJson;

  @override
  String get startTime;
  @override
  String get endTime;
  @override
  int get availableTechnicians;

  /// Create a copy of AvailableSlotModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AvailableSlotModelImplCopyWith<_$AvailableSlotModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlateRestrictionModel _$PlateRestrictionModelFromJson(
  Map<String, dynamic> json,
) {
  return _PlateRestrictionModel.fromJson(json);
}

/// @nodoc
mixin _$PlateRestrictionModel {
  String get vehiclePlate => throw _privateConstructorUsedError;
  String get restrictedDate => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String? get urgentContactMessage => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get businessHours => throw _privateConstructorUsedError;

  /// Serializes this PlateRestrictionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlateRestrictionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlateRestrictionModelCopyWith<PlateRestrictionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlateRestrictionModelCopyWith<$Res> {
  factory $PlateRestrictionModelCopyWith(
    PlateRestrictionModel value,
    $Res Function(PlateRestrictionModel) then,
  ) = _$PlateRestrictionModelCopyWithImpl<$Res, PlateRestrictionModel>;
  @useResult
  $Res call({
    String vehiclePlate,
    String restrictedDate,
    String message,
    String? urgentContactMessage,
    String? phoneNumber,
    String? businessHours,
  });
}

/// @nodoc
class _$PlateRestrictionModelCopyWithImpl<
  $Res,
  $Val extends PlateRestrictionModel
>
    implements $PlateRestrictionModelCopyWith<$Res> {
  _$PlateRestrictionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlateRestrictionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vehiclePlate = null,
    Object? restrictedDate = null,
    Object? message = null,
    Object? urgentContactMessage = freezed,
    Object? phoneNumber = freezed,
    Object? businessHours = freezed,
  }) {
    return _then(
      _value.copyWith(
            vehiclePlate: null == vehiclePlate
                ? _value.vehiclePlate
                : vehiclePlate // ignore: cast_nullable_to_non_nullable
                      as String,
            restrictedDate: null == restrictedDate
                ? _value.restrictedDate
                : restrictedDate // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            urgentContactMessage: freezed == urgentContactMessage
                ? _value.urgentContactMessage
                : urgentContactMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            phoneNumber: freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            businessHours: freezed == businessHours
                ? _value.businessHours
                : businessHours // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlateRestrictionModelImplCopyWith<$Res>
    implements $PlateRestrictionModelCopyWith<$Res> {
  factory _$$PlateRestrictionModelImplCopyWith(
    _$PlateRestrictionModelImpl value,
    $Res Function(_$PlateRestrictionModelImpl) then,
  ) = __$$PlateRestrictionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String vehiclePlate,
    String restrictedDate,
    String message,
    String? urgentContactMessage,
    String? phoneNumber,
    String? businessHours,
  });
}

/// @nodoc
class __$$PlateRestrictionModelImplCopyWithImpl<$Res>
    extends
        _$PlateRestrictionModelCopyWithImpl<$Res, _$PlateRestrictionModelImpl>
    implements _$$PlateRestrictionModelImplCopyWith<$Res> {
  __$$PlateRestrictionModelImplCopyWithImpl(
    _$PlateRestrictionModelImpl _value,
    $Res Function(_$PlateRestrictionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlateRestrictionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vehiclePlate = null,
    Object? restrictedDate = null,
    Object? message = null,
    Object? urgentContactMessage = freezed,
    Object? phoneNumber = freezed,
    Object? businessHours = freezed,
  }) {
    return _then(
      _$PlateRestrictionModelImpl(
        vehiclePlate: null == vehiclePlate
            ? _value.vehiclePlate
            : vehiclePlate // ignore: cast_nullable_to_non_nullable
                  as String,
        restrictedDate: null == restrictedDate
            ? _value.restrictedDate
            : restrictedDate // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        urgentContactMessage: freezed == urgentContactMessage
            ? _value.urgentContactMessage
            : urgentContactMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        phoneNumber: freezed == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        businessHours: freezed == businessHours
            ? _value.businessHours
            : businessHours // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlateRestrictionModelImpl implements _PlateRestrictionModel {
  const _$PlateRestrictionModelImpl({
    required this.vehiclePlate,
    required this.restrictedDate,
    required this.message,
    this.urgentContactMessage,
    this.phoneNumber,
    this.businessHours,
  });

  factory _$PlateRestrictionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlateRestrictionModelImplFromJson(json);

  @override
  final String vehiclePlate;
  @override
  final String restrictedDate;
  @override
  final String message;
  @override
  final String? urgentContactMessage;
  @override
  final String? phoneNumber;
  @override
  final String? businessHours;

  @override
  String toString() {
    return 'PlateRestrictionModel(vehiclePlate: $vehiclePlate, restrictedDate: $restrictedDate, message: $message, urgentContactMessage: $urgentContactMessage, phoneNumber: $phoneNumber, businessHours: $businessHours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlateRestrictionModelImpl &&
            (identical(other.vehiclePlate, vehiclePlate) ||
                other.vehiclePlate == vehiclePlate) &&
            (identical(other.restrictedDate, restrictedDate) ||
                other.restrictedDate == restrictedDate) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.urgentContactMessage, urgentContactMessage) ||
                other.urgentContactMessage == urgentContactMessage) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.businessHours, businessHours) ||
                other.businessHours == businessHours));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    vehiclePlate,
    restrictedDate,
    message,
    urgentContactMessage,
    phoneNumber,
    businessHours,
  );

  /// Create a copy of PlateRestrictionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlateRestrictionModelImplCopyWith<_$PlateRestrictionModelImpl>
  get copyWith =>
      __$$PlateRestrictionModelImplCopyWithImpl<_$PlateRestrictionModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PlateRestrictionModelImplToJson(this);
  }
}

abstract class _PlateRestrictionModel implements PlateRestrictionModel {
  const factory _PlateRestrictionModel({
    required final String vehiclePlate,
    required final String restrictedDate,
    required final String message,
    final String? urgentContactMessage,
    final String? phoneNumber,
    final String? businessHours,
  }) = _$PlateRestrictionModelImpl;

  factory _PlateRestrictionModel.fromJson(Map<String, dynamic> json) =
      _$PlateRestrictionModelImpl.fromJson;

  @override
  String get vehiclePlate;
  @override
  String get restrictedDate;
  @override
  String get message;
  @override
  String? get urgentContactMessage;
  @override
  String? get phoneNumber;
  @override
  String? get businessHours;

  /// Create a copy of PlateRestrictionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlateRestrictionModelImplCopyWith<_$PlateRestrictionModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ReworkInfoModel _$ReworkInfoModelFromJson(Map<String, dynamic> json) {
  return _ReworkInfoModel.fromJson(json);
}

/// @nodoc
mixin _$ReworkInfoModel {
  String get message => throw _privateConstructorUsedError;
  String get whatsappLink => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get businessHours => throw _privateConstructorUsedError;

  /// Serializes this ReworkInfoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReworkInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReworkInfoModelCopyWith<ReworkInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReworkInfoModelCopyWith<$Res> {
  factory $ReworkInfoModelCopyWith(
    ReworkInfoModel value,
    $Res Function(ReworkInfoModel) then,
  ) = _$ReworkInfoModelCopyWithImpl<$Res, ReworkInfoModel>;
  @useResult
  $Res call({
    String message,
    String whatsappLink,
    String phoneNumber,
    String businessHours,
  });
}

/// @nodoc
class _$ReworkInfoModelCopyWithImpl<$Res, $Val extends ReworkInfoModel>
    implements $ReworkInfoModelCopyWith<$Res> {
  _$ReworkInfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReworkInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? whatsappLink = null,
    Object? phoneNumber = null,
    Object? businessHours = null,
  }) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            whatsappLink: null == whatsappLink
                ? _value.whatsappLink
                : whatsappLink // ignore: cast_nullable_to_non_nullable
                      as String,
            phoneNumber: null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            businessHours: null == businessHours
                ? _value.businessHours
                : businessHours // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReworkInfoModelImplCopyWith<$Res>
    implements $ReworkInfoModelCopyWith<$Res> {
  factory _$$ReworkInfoModelImplCopyWith(
    _$ReworkInfoModelImpl value,
    $Res Function(_$ReworkInfoModelImpl) then,
  ) = __$$ReworkInfoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String message,
    String whatsappLink,
    String phoneNumber,
    String businessHours,
  });
}

/// @nodoc
class __$$ReworkInfoModelImplCopyWithImpl<$Res>
    extends _$ReworkInfoModelCopyWithImpl<$Res, _$ReworkInfoModelImpl>
    implements _$$ReworkInfoModelImplCopyWith<$Res> {
  __$$ReworkInfoModelImplCopyWithImpl(
    _$ReworkInfoModelImpl _value,
    $Res Function(_$ReworkInfoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReworkInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? whatsappLink = null,
    Object? phoneNumber = null,
    Object? businessHours = null,
  }) {
    return _then(
      _$ReworkInfoModelImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        whatsappLink: null == whatsappLink
            ? _value.whatsappLink
            : whatsappLink // ignore: cast_nullable_to_non_nullable
                  as String,
        phoneNumber: null == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        businessHours: null == businessHours
            ? _value.businessHours
            : businessHours // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReworkInfoModelImpl implements _ReworkInfoModel {
  const _$ReworkInfoModelImpl({
    required this.message,
    required this.whatsappLink,
    required this.phoneNumber,
    required this.businessHours,
  });

  factory _$ReworkInfoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReworkInfoModelImplFromJson(json);

  @override
  final String message;
  @override
  final String whatsappLink;
  @override
  final String phoneNumber;
  @override
  final String businessHours;

  @override
  String toString() {
    return 'ReworkInfoModel(message: $message, whatsappLink: $whatsappLink, phoneNumber: $phoneNumber, businessHours: $businessHours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReworkInfoModelImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.whatsappLink, whatsappLink) ||
                other.whatsappLink == whatsappLink) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.businessHours, businessHours) ||
                other.businessHours == businessHours));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    whatsappLink,
    phoneNumber,
    businessHours,
  );

  /// Create a copy of ReworkInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReworkInfoModelImplCopyWith<_$ReworkInfoModelImpl> get copyWith =>
      __$$ReworkInfoModelImplCopyWithImpl<_$ReworkInfoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ReworkInfoModelImplToJson(this);
  }
}

abstract class _ReworkInfoModel implements ReworkInfoModel {
  const factory _ReworkInfoModel({
    required final String message,
    required final String whatsappLink,
    required final String phoneNumber,
    required final String businessHours,
  }) = _$ReworkInfoModelImpl;

  factory _ReworkInfoModel.fromJson(Map<String, dynamic> json) =
      _$ReworkInfoModelImpl.fromJson;

  @override
  String get message;
  @override
  String get whatsappLink;
  @override
  String get phoneNumber;
  @override
  String get businessHours;

  /// Create a copy of ReworkInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReworkInfoModelImplCopyWith<_$ReworkInfoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
