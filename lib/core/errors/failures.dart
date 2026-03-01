/// Sealed class hierarchy for domain-level failures.
/// Used with `Either<Failure, T>` from fpdart in repository contracts.
sealed class Failure {
  final String message;
  final int? statusCode;

  const Failure(this.message, {this.statusCode});
}

class ServerFailure extends Failure {
  final Map<String, dynamic>? details;

  const ServerFailure(
    super.message, {
    super.statusCode,
    this.details,
  });
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Sin conexión a internet']);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(
      [super.message = 'Sesión expirada. Inicia sesión nuevamente.']);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Recurso no encontrado']);
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure([super.message = 'No tienes permisos para esta acción']);
}

class ConflictFailure extends Failure {
  const ConflictFailure([super.message = 'Conflicto con los datos enviados']);
}

class ValidationFailure extends Failure {
  final Map<String, dynamic>? fieldErrors;

  const ValidationFailure(
    super.message, {
    this.fieldErrors,
  });
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Error de almacenamiento local']);
}
