/// Raw exception from data layer.
/// Thrown by datasources and caught in repository implementations.
class ServerException implements Exception {
  final String message;
  final int statusCode;
  final Map<String, dynamic>? details;

  const ServerException({
    required this.message,
    required this.statusCode,
    this.details,
  });

  @override
  String toString() => 'ServerException($statusCode): $message';
}

/// Thrown when there is no network connection.
class NetworkException implements Exception {
  final String message;

  const NetworkException({
    this.message = 'Sin conexión a internet',
  });

  @override
  String toString() => 'NetworkException: $message';
}

/// Thrown when the stored token is missing or invalid locally.
class CacheException implements Exception {
  final String message;

  const CacheException({
    this.message = 'Error de almacenamiento local',
  });

  @override
  String toString() => 'CacheException: $message';
}
