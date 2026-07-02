/// Result simplificado (substitui Either do dartz sem trazer a dependência).
sealed class Result<T> {
  const Result();

  factory Result.success(T data) = Success<T>;
  factory Result.failure(Object error) = Error<T>;

  bool get isSuccess => this is Success<T>;

  R when<R>({
    required R Function(T data) success,
    required R Function(Object error) failure,
  }) {
    final self = this;
    if (self is Success<T>) return success(self.data);
    if (self is Error<T>) return failure(self.error);
    throw StateError('Result inválido');
  }
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Error<T> extends Result<T> {
  final Object error;
  const Error(this.error);
}
